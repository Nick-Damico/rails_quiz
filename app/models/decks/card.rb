class Decks::Card < ApplicationRecord
  self.table_name = "cards"

  belongs_to :deck

  validates :front, presence: true
  validates :back, presence: true

  scope :new_cards, ->(user_deck) { where(deck_id: user_deck.deck_id).where.not(id: user_deck.user_deck_cards.select(:card_id)) }

  def self.model_name
    ActiveModel::Name.new(self, Decks)
  end
end
