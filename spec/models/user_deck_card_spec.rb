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

  describe ".due_for_review" do
    let!(:user_deck) { create(:user_deck) }
    let!(:due_card) {
      create(:user_deck_card, user_deck: user_deck, next_review_at: 1.day.ago)
    }
    let!(:upcoming_card) {
      create(:user_deck_card, user_deck: user_deck, next_review_at: 1.day.from_now)
    }
    let!(:new_card) {
      create(:user_deck_card, user_deck: user_deck, next_review_at: nil)
    }

    it "returns cards that are due for review" do
      result = UserDeckCard.due_for_review(user_deck)

      expect(result).to contain_exactly(due_card, new_card)
    end
  end

  describe "#reset_space_repetition!" do
    it "resets the spaced-repetition supporting fields to default values" do
      user_deck_card = create(
        :user_deck_card,
        ease_factor: 1.5,
        interval_days: 5,
        next_review_at: 3.days.from_now,
        successful_reviews: 2
      )

      user_deck_card.reset_space_repetition!

      expect(user_deck_card.ease_factor).to eq(UserDeckCard::EASE_FACTOR_DEFAULT)
      expect(user_deck_card.interval_days).to eq(UserDeckCard::INTERVAL_DAYS_DEFAULT)
      expect(user_deck_card.next_review_at).to eq(UserDeckCard::NEXT_REVIEW_AT_DEFAULT)
      expect(user_deck_card.successful_reviews).to eq(UserDeckCard::SUCCESSFUL_REVIEWS_DEFAULT)
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
