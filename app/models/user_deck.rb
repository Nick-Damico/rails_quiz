class UserDeck < ApplicationRecord
  belongs_to :user
  belongs_to :deck

  has_many :user_deck_cards, dependent: :destroy
  has_many :cards, through: :user_deck_cards

  delegate :cards, to: :deck, allow_nil: true

  # TODO: Move to callback
  def build_user_cards
    return unless cards.present?

    user_deck_cards.build(cards.map { |card| { card: } })
  end

  def find_card_with_fallback(card_id, fallback_method: :first)
    allowed_fallbacks = %i[first last]
    fallback_method = :first unless allowed_fallbacks.include?(fallback_method)

    user_deck_cards.find_by(id: card_id) || user_deck_cards.send(fallback_method)
  end
end
