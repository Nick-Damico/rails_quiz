class AnswerSheetsController < ApplicationController
  before_action :set_answer_sheet, only: %i[show destroy]

  def show
    @quiz = @answer_sheet.quiz
  end

  def create
    @answer_sheet = AnswerSheet.new(answer_sheet_params)
    if @answer_sheet.save
      flash[:notice] = t("flash.answer_sheets.create.success")
      redirect_to @answer_sheet
    else
      flash[:alert] = t("flash.answer_sheets.create.error")
      redirect_to quizzes_path, status: :unprocessable_entity
    end
  end

  def destroy
    if @answer_sheet.destroy
      flash[:notice] = t("flash.answer_sheets.destroy.success")
      redirect_to @answer_sheet.quiz
    else
      flash[:alert] = t("flash.answer_sheets.destroy.error")
      redirect_to @answer_sheet.quiz
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
