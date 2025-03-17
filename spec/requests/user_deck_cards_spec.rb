require 'rails_helper'

RSpec.describe "UserDeckCards", type: :request do
  let(:user) { create(:user) }
  let(:user_deck) { create(:user_deck, user:) }
  let(:user_deck_card) { create(:user_deck_card, user_deck:) }

  before { sign_in user }

  xdescribe "PATCH /update" do
    context "response format HTML" do
      it "returns http redirect" do
        get user_deck_card_path(user_deck_card)

        expect(response).to redirect_to(user_deck_url(user_deck))
      end
    end
  end
end
