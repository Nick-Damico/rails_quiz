class AnswerSheet < ApplicationRecord
  belongs_to :quiz
  belongs_to :user

  has_many :answer_sheet_questions

  def prepare
    quiz.question_ids.each do |question_id|
      answer_sheet_questions << AnswerSheetQuestion.create(question_id:)
    end
  end

  def next_incomplete_question
    answer_sheet_questions.incomplete.first
  end
end
