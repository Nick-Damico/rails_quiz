
require "rails_helper"


RSpec.describe "UserDeck", type: :request do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck) }

  before { sign_in user }

  describe "POST /create" do
    context "with valid params" do
      let!(:valid_params) { { user_deck: { user_id: user.id, deck_id: deck.id } } }

      it "responds with HTTP status redirect(302)" do
        post user_decks_path, params: valid_params

        expect(response).to have_http_status(:redirect)
      end

      it "creates a user_deck record" do
        expect {
          post user_decks_path, params: valid_params
        }.to change(UserDeck, :count).by(1)
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
    end
  end
end
