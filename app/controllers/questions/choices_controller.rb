class Questions::ChoicesController < ApplicationController
  before_action :set_choice, only: %i[]
  before_action :set_question, only: %i[new create]
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

  private

  def choice_params
    params.require(:question_choice).permit(:content, :correct, :question_id)
  end

  def set_choice
    @choice = Choice.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
