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
    describe "#update_ease_factor" do
      it "calculates the new ease factor based on the user provided card rating" do
        user_deck_card.card_rating = :correct # quality = 2

        expect(user_deck_card.ease_factor).to eq(2.5) # intial ease factor

        expect(user_deck_card.update_ease_factor).to eq(2.18)
      end
    end

    describe "#increment_successful_reviews" do
      it "increments the successful reviews count if the card rating is correct" do
        user_deck_card.card_rating = :correct

        expect(user_deck_card.successful_reviews).to eq(0)

        expect(user_deck_card.increment_successful_reviews).to eq(1)
      end

      it "resets the successful reviews count to zero if the card rating is incorrect" do
        user_deck_card.card_rating = :correct
        user_deck_card.increment_successful_reviews

        expect(user_deck_card.successful_reviews).to eq(1)

        user_deck_card.card_rating = :incorrect

        expect(user_deck_card.increment_successful_reviews).to eq(0)
      end
    end
    describe "#update_interval_days" do
      it "sets the next interval to 1 day if correct on first review" do
        user_deck_card.card_rating = :correct
        user_deck_card.increment_successful_reviews

        expect(user_deck_card.interval_days).to eq(0)

        user_deck_card.update_interval_days
        expect(user_deck_card.interval_days).to eq(1)
      end
      it "sets the next interval to 3 days if correct on second review" do
        user_deck_card.card_rating = :correct
        user_deck_card.interval_days = 1 # value if correct on first review
        user_deck_card.successful_reviews = 2

        user_deck_card.update_interval_days

        expect(user_deck_card.interval_days).to eq(3)
      end

      it "resets the next interval to 1 day if incorrect" do
        user_deck_card.card_rating = :incorrect
        user_deck_card.interval_days = 1 # value if correct on first review
        user_deck_card.successful_reviews = 2

        user_deck_card.update_interval_days

        expect(user_deck_card.interval_days).to eq(1)
      end

      it "calculates the next interval based on ease factor if correct on third or later review" do
        user_deck_card.card_rating = :correct
        user_deck_card.interval_days = 3
        user_deck_card.successful_reviews = 3
        user_deck_card.ease_factor = 2.5

        user_deck_card.update_interval_days

        expect(user_deck_card.interval_days).to eq(8)
      end
    end
    describe "#update_review_at" do
      it "sets next review date for the next day on first success" do
        user_deck_card.card_rating = :correct
        user_deck_card.interval_days = 1 # value if correct on first review
        user_deck_card.successful_reviews = 1

        freeze_time do
          user_deck_card.update_review_at

          expect(user_deck_card.update_review_at).to eq(1.days.from_now)
        end
      end
    end
  end
end
