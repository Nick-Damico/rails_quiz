class AnswerSheetQuestionsController < ApplicationController
  before_action :set_answer_sheet_question, only: %i[show update]

  def show
    set_show_variables
  end

  def update
    if @answer_sheet_question.update(answer_sheet_question_params)
      answer_sheet = @answer_sheet_question.answer_sheet
      flash[:notice] = t("flash.answer_sheet_questions.update.success")
      redirect_to answer_sheet.next_incomplete_question
    else
      flash[:alert] = t("flash.answer_sheet_questions.update.error")
      set_show_variables

      render :show, status: :unprocessable_entity
    end
  end

  private

  def answer_sheet_question_params
    params.require(:answer_sheet_question).permit(:answer_id)
  end

  def set_answer_sheet_question
    @answer_sheet_question = AnswerSheetQuestion.find(params[:id])
  end

  def set_show_variables
    answer_sheet = @answer_sheet_question.answer_sheet
    @question_count = answer_sheet.answer_sheet_questions.count
    @question = @answer_sheet_question.question
  end
end
