class AnswerSheetQuestion < ApplicationRecord
  belongs_to :answer_sheet
  belongs_to :question
  belongs_to :answer, class_name: "Question::Choice", optional: true

  scope :incomplete, -> { where(answer: nil) }

  def position
    answer_sheet.position_of(self) + 1
  end
end
