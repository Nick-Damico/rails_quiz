require "rails_helper"

RSpec.describe "Decks", type: :request do
  let!(:user) { create(:user) }

  before { sign_in user }

  describe "GET /index" do
    it "returns http success" do
      get decks_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "responds with HTTP status ok(200)" do
      deck = create(:deck)
      get deck_path(deck)

      expect(response).to have_http_status(:ok)
    end
  end
end
