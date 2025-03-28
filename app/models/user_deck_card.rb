class UserDeckCard < ApplicationRecord
  belongs_to :user_deck
  belongs_to :card, class_name: "Decks::Card"

  scope :group_by_rating, ->(user_deck) { where(user_deck_id: user_deck.id).group(:card_rating).count }

  delegate :deck, to: :user_deck

  enum :card_rating, { not_rated: 0, correct: 1, incorrect: 2 }

  def reset_rating!
    not_rated!
  end
end
