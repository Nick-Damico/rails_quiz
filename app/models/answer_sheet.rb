class AnswerSheet < ApplicationRecord
  belongs_to :quiz
  belongs_to :user

  has_many :answer_sheet_questions, -> { order(id: :asc) }, dependent: :destroy

  def self.in_progress_answer_sheet_for(quiz:, user:)
    AnswerSheet
      .joins(:answer_sheet_questions)
      .where(quiz:, user:,  answer_sheet_questions: { answer: nil })
      .distinct
      .first
  end

  def completed?
    answer_sheet_questions.all?(&:answered?)
  end

  def prepare
    quiz.question_ids.each do |question_id|
      answer_sheet_questions << AnswerSheetQuestion.create(question_id:)
    end
  end

  def position_of(answer_sheet_question)
    answer_sheet_questions.pluck(:id).index(answer_sheet_question.id)
  end

  def next_incomplete_question
    answer_sheet_questions.incomplete.first
  end
end
