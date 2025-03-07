class UserDeckCard < ApplicationRecord
  belongs_to :user_deck
  belongs_to :card, class_name: "Decks::Card"

  delegate :deck, to: :user_deck
end
