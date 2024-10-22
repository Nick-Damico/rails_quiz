class QuizzesController < ApplicationController
  before_action :set_author, only: %i[new create]

  def new
    @quiz = @author.quizzes.new
  end

  def create
    @quiz = @author.quizzes.create(quiz_params)
    if @quiz.save
      redirect_to root_url
    else
      flash.now[:alert] = @quiz.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:name, :description, :author_id)
  end

  def set_author
    @author = User.find(params[:author_id])
  end
end
