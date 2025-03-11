require 'rails_helper'

RSpec.describe "UserDeckCards", type: :request do
  let(:user) { create(:user) }
  let(:user_deck) { create(:user_deck, user:) }
  let(:user_deck_card) { create(:user_deck_card, user_deck:) }

  before { sign_in user }

  describe "GET /show" do
    it "returns http success" do
      get user_deck_card_path(user_deck_card)

      expect(response).to have_http_status(:success)
    end
  end
end
