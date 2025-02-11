class Deck::Card < ApplicationRecord
  self.table_name = "cards"

  belongs_to :deck

  validates :front, presence: true
  validates :back, presence: true
end
