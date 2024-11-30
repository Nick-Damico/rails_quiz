class QuestionsController < ApplicationController
  before_action :set_quiz, only: %i[create edit new show update]
  before_action :set_question, only: %i[edit show update destroy]

  def show
  end

  def new
    @question = @quiz.questions.build
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = t("flash.questions.create.success")
      respond_to do |format|
        format.html { redirect_to quiz_url(@quiz, author_id: @quiz.author) }
      end
    else
      flash.now[:alert] = t("flash.questions.create.error")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      flash[:notice] = t("flash.questions.update.success")
      redirect_to quiz_question_url(@quiz, @question)
    else
      flash.now[:error] = t("flash.questions.update.error")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @question.destroy
      flash.now[:notice] = t("flash.questions.destroy.success")
    else
      flash.now[:error] = t("flash.questions.destroy.error")
    end

    redirect_to quizzes_url(author_id: @author)
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:quiz_id, :content)
  end
end
