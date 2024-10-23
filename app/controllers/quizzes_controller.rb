class QuizzesController < ApplicationController
  before_action :set_author, only: %i[index create new]

  def index
    @quizzes = @author.quizzes
  end

  def new
    @quiz = @author.quizzes.new
  end

  def create
    @quiz = @author.quizzes.create(quiz_params)
    if @quiz.save
      flash[:notice] = t("flash.quizzes.create.success")
      redirect_to author_quizzes_url(@author)
    else
      flash.now[:alert] = @quiz.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:title, :description, :author_id)
  end

  def set_author
    @author = User.find(params[:author_id])
  end
end
