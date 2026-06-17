class UserDeckCard < ApplicationRecord
  belongs_to :user_deck
  belongs_to :card, class_name: "Decks::Card"

  scope :by_user_deck, ->(user_deck) { where(user_deck_id: user_deck.id) }
  scope :group_by_rating, ->(user_deck) { by_user_deck(user_deck).group(:card_rating) }
  scope :due_for_review, ->(user_deck) { by_user_deck(user_deck).where("next_review_at <= ? OR next_review_at IS NULL", Time.current) }

  delegate :deck, to: :user_deck

  enum :card_rating, {
    not_rated: 0,
    incorrect: 1,
    correct: 2
  }

  EASE_FACTOR_DEFAULT         = 2.5
  INTERVAL_DAYS_DEFAULT       = 0
  NEXT_REVIEW_AT_DEFAULT      = nil
  SUCCESSFUL_REVIEWS_DEFAULT  = 0

  def calcuate_next_recall
    self.ease_factor        = update_ease_factor
    self.successful_reviews = increment_successful_reviews
    self.interval_days      = update_interval_days
    self.next_review_at     = update_review_at
  end


  def reset_rating!
    not_rated!
  end

  def reset_space_repetition!
    self.update_columns(
      ease_factor: EASE_FACTOR_DEFAULT,
      interval_days: INTERVAL_DAYS_DEFAULT,
      next_review_at: NEXT_REVIEW_AT_DEFAULT,
      successful_reviews: SUCCESSFUL_REVIEWS_DEFAULT
    )
  end

  private

    def card_rating_numeric_value
      UserDeckCard.card_ratings[card_rating.to_s]
    end

    # SR METHODS
    def increment_successful_reviews
      correct? ? successful_reviews + 1 : 0
    end

    # SM-2 algorithm:
    def update_ease_factor
      card_rating_val = card_rating_numeric_value

      ease_factor + (
        0.1 -
          (5 - card_rating_val) *
            (
              0.08 +
              (5 - card_rating_val) *
              0.02
          ))
    end

    def update_interval_days
      if correct?
        case successful_reviews
        when 1 then 1
        when 2 then 3
        else  (interval_days * ease_factor).round
        end
      else
        1
      end
    end

    def update_review_at
      interval_days.days.from_now
    end
end
