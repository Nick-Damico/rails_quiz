class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[destroy edit update]
  before_action :set_author, only: %i[create destroy edit index new]

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

  def edit
  end

  def update
    if @quiz.update(quiz_params)
      flash[:notice] = t("flash.quizzes.update.success")
      redirect_to author_quizzes_url(@quiz.author)
    else
      # TODO: Display attirbutes and error messages on forms
      @author = @quiz.author
      flash[:alert] = t("flash.quizzes.update.error")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @quiz.destroy
      flash[:notice] = t("flash.quizzes.delete.success")
      redirect_to author_quizzes_url(@author)
    else
      flash[:alert] = t("flash.quizzes.delete.error")
      redirect_to author_quizzes_url(@author)
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:title, :description, :author_id)
  end

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  def set_author
    @author = User.find(params[:author_id])
  end
end
