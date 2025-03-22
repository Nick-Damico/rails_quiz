require "rails_helper"

RSpec.describe "user_decks/summaries", type: :request do
  let(:user) { create(:user) }
  let!(:user_deck) { create(:user_deck, :with_user_deck_cards, :with_completed, user:) }

  before { sign_in user }

  describe "GET /user_decks/:id/summary" do
    it "renders a successful response" do
      get user_deck_summary_path(user_deck)

      expect(response).to have_http_status(:ok)
    end

    context "incomplete user_deck" do
      it 'redirects to the flashcard deck page' do
        user_deck = create(:user_deck, :with_user_deck_cards, user:)

        get user_deck_summary_path(user_deck)

        expect(response).to redirect_to(deck_url(user_deck.deck))
      end

      it "displays a flash alert msg" do
        user_deck = create(:user_deck, :with_user_deck_cards, user:)

        get user_deck_summary_path(user_deck)

        expect(flash[:alert]).to eq("Access denied. You must complete a review of this deck.")
      end
    end
  end
end
