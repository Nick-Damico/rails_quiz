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

  describe ".group_by_rating" do
    it "groups the cards by rating" do
      user_deck = create(:user_deck, :with_user_deck_cards)
      user_deck.user_deck_cards.first.correct!
      user_deck.user_deck_cards.last.incorrect!

      result = UserDeckCard.group_by_rating(user_deck).count

      expect(result).to eq({ "correct" => 1, "incorrect" => 1 })
    end
  end

  context "space repetition" do
    let(:user_deck_card) { create(:user_deck_card) }
    describe "#update_ease_factor" do
      it "calculates the new ease factor based on the user provided card rating" do
        user_deck_card.card_rating = :correct # quality = 2

        expect(user_deck_card.ease_factor).to eq(2.5) # intial ease factor

        expect(user_deck_card.update_ease_factor).to eq(2.18)
      end
    end
end
