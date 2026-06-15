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

  def reset_rating!
    not_rated!
  end
end
