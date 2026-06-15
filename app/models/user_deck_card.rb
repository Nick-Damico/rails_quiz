class UserDeckCard < ApplicationRecord
  belongs_to :user_deck
  belongs_to :card, class_name: "Decks::Card"

  scope :by_user_deck, ->(user_deck) { where(user_deck_id: user_deck.id) }
  scope :group_by_rating, ->(user_deck) { by_user_deck(user_deck).group(:card_rating) }

  delegate :deck, to: :user_deck

  enum :card_rating, {
    not_rated: 0,
    incorrect: 1,
    correct: 2
  }

  def increment_successful_reviews
    self.successful_reviews =
      if correct?
        successful_reviews + 1
      elsif incorrect?
        0
      end
  end

  # SM-2 algorithm:
  def update_ease_factor
    card_rating_val = card_rating_numeric_value

    self.ease_factor = ease_factor + (
      0.1 -
      (5 - card_rating_val) *
        (
          0.08 +
          (5 - card_rating_val) *
          0.02
        ))
  end

  def update_interval_days
    self.interval_days =
      if correct?
        case successful_reviews
        when 1 then 1
        when 2 then 3
        else
          (interval_days * ease_factor).round
        end
      else
        1
      end
  end

  def update_review_at
    self.next_review_at = interval_days.days.from_now
  end

  def reset_rating!
    not_rated!
  end

  private

    def card_rating_numeric_value
      UserDeckCard.card_ratings[card_rating.to_s]
    end
end
