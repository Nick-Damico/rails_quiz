require 'rails_helper'

RSpec.describe UserDeckCard, type: :model do
  it { should belong_to(:user_deck) }
  it { should belong_to(:card) }

  describe "#reset_rating!" do
    it "resets the rating to not_rated" do
      user_deck_card = build(:user_deck_card, card_rating: :correct)

      user_deck_card.reset_rating!

      expect(user_deck_card.not_rated?).to be(true)
    end
  end
end
