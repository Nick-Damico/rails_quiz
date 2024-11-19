class QuestionsController < ApplicationController
  before_action :set_quiz

  def new
    @question = @quiz.questions.build
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = t("flash.questions.create.success")
      redirect_to quiz_url(@quiz, author_id: @quiz.author)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def question_params
    params.require(:question).permit(:quiz_id, :content)
  end
end
