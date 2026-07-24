class Quiz < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :category
  has_many :questions, dependent: :destroy

  validates_presence_of :title
  validates_presence_of :author

  PUBLISHABLE_QUESTION_COUNT = 5
  SECONDS_PER_QUESTION = 30.0

  # Future update with allow the Author to set the
  # estimated time per question. This will allow for more or
  # less time based on question difficulty.
  def publish!
    update_column(:published_at, Time.current) if publishable?
  end

  def publishable?
    questions.count >= PUBLISHABLE_QUESTION_COUNT
  end

  def published?
    published_at.present?
  end

  def time_to_complete
    ActiveSupport::Duration.build(questions.count * SECONDS_PER_QUESTION).to_i
  end

  # NOTE: Eventually this will need some clean-up. We will need to notify users that had this as part of their study_plans.
  def unpublish!
    update_column(:published_at, nil)
  end
end
