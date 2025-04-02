require 'rails_helper'

RSpec.describe "UserDeckCards", type: :request do
  let(:user) { create(:user) }
  let(:user_deck) { create(:user_deck, user:) }
  let(:user_deck_card) { create(:user_deck_card, user_deck:) }

  before { sign_in user }

  describe "PATCH /update" do
    let(:valid_params) { { user_deck_card: { card_rating: :correct } } }

    it "responds with http ok(201)" do
      patch user_deck_card_path(user_deck_card), params: valid_params

      expect(response).to have_http_status(:ok)
    end

    context "rating" do
      it "updates the records card_rating" do
        put user_deck_card_path(user_deck_card), params: valid_params

        expect(user_deck_card.reload.card_rating).to eq("correct")
      end
    end
  end
end
