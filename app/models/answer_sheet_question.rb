class AnswerSheetQuestion < ApplicationRecord
  belongs_to :answer_sheet
  belongs_to :question
  belongs_to :answer, class_name: "Question::Choice", optional: true

  scope :complete, -> { where.not(answer: nil) }
  scope :incomplete, -> { where.not(id: complete) }

  scope :correct, -> { joins(:answer).merge(Question::Choice.correct) }
  scope :incorrect, -> { joins(:answer).merge(Question::Choice.incorrect) }

  scope :for_answer_sheet, ->(answer_sheet) { where(answer_sheet:) }

  validates :answer, presence: true, on: :update

  def answered?
    answer_id.present?
  end

  def position
    answer_sheet.position_of(self) + 1
  end
end
