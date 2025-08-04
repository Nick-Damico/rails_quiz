class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[show]
  before_action :set_breadcrumbs

  def index
    @quizzes = policy_scope(Quiz)
  end

  def show
    authorize @quiz
    @in_progress_answer_sheet = AnswerSheet.in_progress_answer_sheet_for(quiz: @quiz, user: current_user)
  end

  private

    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    def record_not_found_redirect_url
      quizzes_url
    end

    def unauthorized_redirect_url
      record_not_found_redirect_url
    end

    def set_breadcrumbs
      add_breadcrumb("Study")
      add_breadcrumb("Quizzes", quizzes_path)
      if @quiz.present?
        add_breadcrumb(@quiz.title, quiz_path(@quiz))
      end
    end
end
