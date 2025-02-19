class Deck < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :cards, class_name: "Decks::Card"

  validates :title, presence: true
end
