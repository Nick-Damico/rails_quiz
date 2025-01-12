class AnswerSheetQuestionsController < ApplicationController
  before_action :set_answer_sheet_question, only: %i[show]

  def show
    @question = @answer_sheet_question.question
    @choices = @question.choices
  end

  private

  def set_answer_sheet_question
    @answer_sheet_question = AnswerSheetQuestion.find(params[:id])
  end
end
