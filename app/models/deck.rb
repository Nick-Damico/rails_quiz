class Deck < ApplicationRecord
  belongs_to :author, class_name: "User"

  has_many :cards, class_name: "Decks::Card"
  has_many :user_decks
  has_many :users, through: :user_decks

  validates :title, presence: true

  def time_to_complete
    avg_time_per_card = 10
    ActiveSupport::Duration.build(cards.count * avg_time_per_card).to_i
  end
end
