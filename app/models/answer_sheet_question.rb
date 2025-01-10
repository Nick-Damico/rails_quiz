class AnswerSheetQuestion < ApplicationRecord
  belongs_to :answer_sheet
  belongs_to :question
  belongs_to :answer, class_name: "Question::Choice", optional: true
end
