class Questions::ChoicesController < ApplicationController
  before_action :set_choice, only: %i[destroy edit update]
  before_action :set_question, only: %i[create destroy edit new update]
  def new
    respond_to do |format|
      format.turbo_stream do
        @new_index = params["choice_count"]
      end
      format.html do
        @choice = @question.choices.new
      end
    end
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

      respond_to do |format|
        format.html { redirect_to quiz_question_url(@question.quiz_id, @question), status: :no_content }
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@choice) }
      end
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

  # The "new" parameter for :question_id is used to handle dynamically building a new
  # choice form element when the question is not yet persisted. This supports nested
  # attributes functionality for the choices fields on the new question form.
  def set_question
    @question =
      if params[:question_id] == "new"
        Question.new
      else
        Question.find(params[:question_id])
      end
  end
end
