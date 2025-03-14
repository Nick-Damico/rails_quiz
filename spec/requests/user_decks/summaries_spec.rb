require "rails_helper"

RSpec.describe "user_decks/summaries", type: :request do
  let(:user) { create(:user) }
  let!(:user_deck) { create(:user_deck, :with_user_deck_cards, user:) }

  before { sign_in user }

  describe "GET /user_decks/:user_id/summaries" do
    it "renders a successful response" do
      get user_deck_summaries_path(user_deck)

      expect(response).to have_http_status(:ok)
    end
  end
end
