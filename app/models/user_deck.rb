class UserDeck < ApplicationRecord
  belongs_to :user
  belongs_to :deck

  has_many :user_deck_cards, dependent: :destroy
  has_many :cards, through: :user_deck_cards

  delegate :cards, to: :deck, allow_nil: true
  def build_user_cards
    return unless cards.present?

    user_deck_cards.build(cards.map { |card| { card: } })
  end
end
