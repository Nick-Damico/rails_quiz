class AnswerSheetQuestion < ApplicationRecord
  belongs_to :answer_sheet
  belongs_to :question
  belongs_to :answer, class_name: "Question::Choice", optional: true

  scope :incomplete, -> { where(answer: nil) }

  validates :answer, presence: true, on: :update

  def answered?
    answer.present?
  end

  def position
    answer_sheet.position_of(self) + 1
  end
end
