require 'rails_helper'

RSpec.describe UserDeckCard, type: :model do
  include ActiveSupport::Testing::TimeHelpers

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

    describe "#calcuate_next_recall" do
      it "updates the ease factor, successful reviews, interval days, and next review date based on the card rating" do
        user_deck_card.card_rating = :correct
        expect(user_deck_card.interval_days).to eq(0)
        expect(user_deck_card.successful_reviews).to eq(0)

        freeze_time do
          user_deck_card.calcuate_next_recall

          expect(user_deck_card.ease_factor).to eq(BigDecimal("2.18"))
          expect(user_deck_card.successful_reviews).to eq(1)
          expect(user_deck_card.next_review_at).to eq(1.days.from_now)
          expect(user_deck_card.interval_days).to eq(1)
        end
      end
      it "resets the successful reviews count to zero if the card rating is incorrect" do
        user_deck_card.successful_reviews = 2

        user_deck_card.card_rating = :incorrect

        user_deck_card.calcuate_next_recall

        expect(user_deck_card.successful_reviews).to eq(0)
      end

      it "sets the next interval to 3 days if correct on second review" do
        user_deck_card.card_rating = :correct
        user_deck_card.successful_reviews = 1
        user_deck_card.interval_days = 1

        user_deck_card.calcuate_next_recall

        expect(user_deck_card.interval_days).to eq(3)
      end
    end
  end
end
