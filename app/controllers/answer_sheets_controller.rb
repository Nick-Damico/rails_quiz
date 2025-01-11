class AnswerSheetsController < ApplicationController
  before_action :set_answer_sheet, only: %i[show]

  def show
  end

  def create
    @answer_sheet = AnswerSheet.new(answer_sheet_params)
    if @answer_sheet.save
      redirect_to @answer_sheet
    else
      flash[:alert] = "Sorry there was an error processing this request"
      redirect_to quizzes_path, status: :unprocessable_entity
    end
  end

  private

  def set_answer_sheet
    @answer_sheet = AnswerSheet.find(params[:id])
  end

  def answer_sheet_params
    params.require(:answer_sheet).permit(:quiz_id, :user_id)
  end
end
