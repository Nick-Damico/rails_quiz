class Quiz < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :questions, dependent: :destroy

  validates_presence_of :title
  validates_presence_of :author

  SECONDS_PER_QUESTION = 30.0

  # Future update with allow the Author to set the
  # estimated time per question. This will allow for more or
  # less time based on question difficulty.
  def time_to_complete
    ActiveSupport::Duration.build(questions.count * SECONDS_PER_QUESTION).to_i
  end
end
