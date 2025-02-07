class AnswerSheetQuestionsController < ApplicationController
  before_action :set_answer_sheet_question, only: %i[show update]
  before_action :authorize_access!

  def show
    set_show_variables
  end

  def update
    if @answer_sheet_question.update(answer_sheet_question_params)
      answer_sheet = @answer_sheet_question.answer_sheet
      if answer_sheet.completed?
        redirect_to answer_sheet
      else
        flash[:notice] = t("flash.answer_sheet_questions.update.success")
        redirect_to answer_sheet.next_incomplete_question
      end
    else
      set_show_variables
      flash[:alert] = t("flash.answer_sheet_questions.update.error")
      render :show, status: :unprocessable_entity
    end
  end

  private

  def authorize_access!
    authorize @answer_sheet_question
  end

  def answer_sheet_question_params
    params.require(:answer_sheet_question).permit(:answer_id)
  end

  def set_answer_sheet_question
    @answer_sheet_question = AnswerSheetQuestion.find(params[:id])
  end

  def set_show_variables
    @question = @answer_sheet_question.question
    @question_count = @answer_sheet_question.answer_sheet.answer_sheet_questions.count
  end
end
