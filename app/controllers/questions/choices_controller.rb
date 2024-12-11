class Questions::ChoicesController < ApplicationController
  before_action :set_choice, only: %i[destroy edit update]
  before_action :set_question, only: %i[create destroy edit new update]
  def new
    @choice = @question.choices.new
  end

  def create
    @choice = Question::Choice.new(choice_params)
    if @choice.save
      flash[:notice] = t("flash.choices.create.success")
      redirect_to quiz_question_url(@question.quiz_id, @question)
    else
      flash.now[:alert] = t("flash.choices.create.error")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @choice.update(choice_params)
      flash[:notice] = t("flash.choices.update.success")
      redirect_to quiz_question_url(@question.quiz_id, @question)
    else
      flash.now[:alert] = t("flash.choices.update.error")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @choice.destroy
      flash[:notice] = t("flash.choices.destroy.success")
      redirect_to quiz_question_url(@question.quiz_id, @question), status: :no_content
    else
      flash[:alert] = t("flash.choices.destroy.error")
      redirect_to quiz_question_url(@question.quiz_id, @question), status: :bad_request
    end
  end

  private

  def choice_params
    params.require(:question_choice).permit(:content, :correct, :question_id)
  end

  def set_choice
    @choice = Question::Choice.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
