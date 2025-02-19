require 'rails_helper'

RSpec.describe "Decks::Cards", type: :request do
  let!(:author) { create(:user) }
  let!(:deck) { create(:deck, author:) }

  before { sign_in author }


  describe "GET /show" do
    it "responds with HTTP status ok(200)" do
      card = create(:card, deck:)
      get card_path(card)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /new" do
    it "responds with HTTP status ok(200)" do
      get new_deck_card_path(deck_id: deck.id)

      expect(response).to have_http_status(:ok)
end
