class Question::Choice < ApplicationRecord
  extend ActiveModel::Naming
  belongs_to :question

  scope :correct, -> { where(correct: true) }
  scope :incorrect, -> { where(correct: false) }

  validates_presence_of(:question)
  validates_presence_of(:content)
  validates :correct, inclusion: [ true, false ]

  # INFO: This prevents form_with url helpers
  # from generating incorrect routes like: question_question_choices_*.
  # This was the suggested work-around for dealing with the above issue when
  # using nested routes/models.
  def self.model_name
    ActiveModel::Name.new(self, Question)
  end
end
