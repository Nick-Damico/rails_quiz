class AnswerSheetsController < ApplicationController
  before_action :set_answer_sheet, only: %i[pause resume show destroy]
  before_action :set_breadcrumbs, only: %i[show]

  def resume
    if answer_sheet_question = @answer_sheet.next_incomplete_question
      redirect_to answer_sheet_question
    else
      redirect_to @answer_sheet.quiz
    end
  end

  # INFO: This route doesn't do much of anything for now.
  #        It provides the User with a route to intentionally
  #        navigate away from the 'in-progess' Quiz. In the
  #        future, this might pause a clock or save some state.
  def pause
    flash[:notice] = t("flash.answer_sheets.pause.success")
    redirect_to @answer_sheet.quiz
  end

  def show
    unless @answer_sheet.completed?
      flash[:alert] = t("flash.answer_sheets.show.error")
      return redirect_to @answer_sheet.quiz
    end

    if !@answer_sheet.graded?
      # TOOD: Handle exception raised by grader
      AnswerSheet::Grader.new(@answer_sheet).grade
    end

    @question_count                     = @answer_sheet.answer_sheet_questions.count

    @correct_answer_sheet_questions     = AnswerSheetQuestion.includes(question: :choices).correct_for_answer_sheet(@answer_sheet)
    @correct_count                      = @correct_answer_sheet_questions.count

    @incorrect_answer_sheet_questions   = AnswerSheetQuestion.includes(question: :choices).incorrect_for_answer_sheet(@answer_sheet)
    @incorrect_count                    = @incorrect_answer_sheet_questions.count
  end

  def create
    @answer_sheet = AnswerSheet.new(answer_sheet_params)
    if @answer_sheet.save
      @answer_sheet.prepare

      flash[:notice] = t("flash.answer_sheets.create.success")
      redirect_to @answer_sheet.answer_sheet_questions.first
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

  def set_breadcrumbs
    add_breadcrumb("Study")
    add_breadcrumb("Quizzes", quizzes_path)
    if @answer_sheet&.quiz
      add_breadcrumb(@answer_sheet.quiz.title, quiz_path(@answer_sheet.quiz))
    end
    add_breadcrumb("Summary")
  end

  def set_answer_sheet
    @answer_sheet = AnswerSheet.find(params[:id])
  end

  def answer_sheet_params
    params.require(:answer_sheet).permit(:quiz_id, :user_id)
  end
end
