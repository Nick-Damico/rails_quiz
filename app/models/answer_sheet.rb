class AnswerSheet < ApplicationRecord
  belongs_to :quiz
  belongs_to :user

  has_many :answer_sheet_questions
end
