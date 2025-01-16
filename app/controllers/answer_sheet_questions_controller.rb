class AnswerSheetQuestionsController < ApplicationController
  before_action :set_answer_sheet_question, only: %i[show update]

  def show
    @question = @answer_sheet_question.question
    @choices = @question.choices
  end

  def update
    if @answer_sheet_question.update(answer_sheet_question_params)
      answer_sheet = @answer_sheet_question.answer_sheet
      redirect_to answer_sheet.next_incomplete_question
    end
  end

  private

  def answer_sheet_question_params
    params.require(:answer_sheet_question).permit(:answer_id)
  end

  def set_answer_sheet_question
    @answer_sheet_question = AnswerSheetQuestion.find(params[:id])
  end
end
