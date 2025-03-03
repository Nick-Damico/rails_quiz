class Decks::Card < ApplicationRecord
  # extend ActiveModel::Naming
  self.table_name = "cards"

  belongs_to :deck

  validates :front, presence: true
  validates :back, presence: true

  def self.model_name
    ActiveModel::Name.new(self, Decks)
  end
end
