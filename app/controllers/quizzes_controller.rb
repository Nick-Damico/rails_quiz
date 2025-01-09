class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[show]
  before_action :set_breadcrumbs

  def index
    @quizzes = Quiz.all
  end

  def show
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  def set_breadcrumbs
    add_breadcrumb("Study")
    add_breadcrumb("Quizzes", quizzes_path)
    if @quiz.present?
      add_breadcrumb(@quiz.title, quiz_path(@quiz))
    end
  end
end
