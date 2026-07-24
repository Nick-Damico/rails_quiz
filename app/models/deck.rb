class Deck < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :category

  has_many :cards, class_name: "Decks::Card"
  has_many :user_decks
  has_many :users, through: :user_decks

  validates :title, presence: true

  PUBLISHABLE_CARD_COUNT = 5

  def publish!
    update_column(:published_at, Time.current) if publishable?
  end

  def publishable?
    cards.count >= PUBLISHABLE_CARD_COUNT
  end

  def published?
    published_at.present?
  end

  def time_to_complete
    avg_time_per_card = 15
    ActiveSupport::Duration.build(cards.count * avg_time_per_card).to_i
  end

  # NOTE: Eventually this will need some clean-up. We will need to notify users that had this as part of their study_plans.
  def unpublish!
    update_column(:published_at, nil)
  end
end
