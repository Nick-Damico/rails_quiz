
require "rails_helper"


RSpec.describe "UserDeck", type: :request do
  let!(:user) { create(:user) }

  before { sign_in user }

  describe "POST /create" do
    let!(:deck) { create(:deck, card_count: 2) }

    context "with valid params" do
      let!(:valid_params) { { user_deck: { user_id: user.id, deck_id: deck.id } } }
      let(:post_request) { post user_decks_path, params: valid_params }

      it "responds with HTTP status redirect(302)" do
        post_request

        expect(response).to have_http_status(:redirect)
      end

      context "without an existing user_deck" do
        it "creates a user_deck record" do
          expect { post_request }.to change(UserDeck, :count).by(1)
        end

        it "builds user_deck_cards" do
          expect { post_request }.to change(UserDeckCard, :count).by(2)
        end
      end

      context "with an existing user_deck" do
        let!(:user_deck) { create(:user_deck, user:, deck:) }

        it "does not create a user_deck record, it finds existing record" do
          expect { post_request }.to change(UserDeck, :count).by(0)
        end

        context "with user_deck_cards" do
          it "does not build user_deck_cards" do
            user_deck.build_user_cards
            user_deck.save

            expect { post_request }.to change(UserDeckCard, :count).by(0)
          end
        end

        context "without user_deck_cards" do
          it "builds user_deck_cards" do
            expect { post_request }.to change(UserDeckCard, :count).by(2)
          end
        end
      end
    end


    context "with invalid params" do
      # invalid due to missing :deck_id
      let!(:invalid_params) { { user_deck: { user_id: user.id, deck_id: nil } } }

      it "does not create a user_deck record" do
        expect {
          post user_decks_path, params: invalid_params
        }.to change(UserDeck, :count).by(0)
      end

      it "responds with HTTP status redirect(302) and alert msg" do
        post user_decks_path, params: invalid_params

        expect(response).to have_http_status(:redirect)
        expect(flash[:alert]).to eq("There was an error starting this study session. Refresh page and try again.")
      end

      it "does not build user_deck_cards" do
        expect {
        post user_decks_path, params: invalid_params
      }.to change(UserDeckCard, :count).by(0)
      end
    end
  end

  describe "GET /show" do
    let!(:user_deck) { create(:user_deck, :with_user_deck_cards, user: user) }

    it "responds with HTTP status success" do
      get user_deck_path(user_deck)

      expect(response).to have_http_status(:success)
    end
  end
end
