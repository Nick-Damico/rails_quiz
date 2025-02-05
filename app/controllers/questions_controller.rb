class QuestionsController < ApplicationController
  before_action :set_quiz, only: %i[create edit new show update]
  before_action :set_question, only: %i[edit show update destroy]
  before_action :set_breadcrumbs
  before_action :authorize_access!, except: %i[create new]

  def show
    @question_ids = @quiz.questions.collect(&:id)
  end

  def new
    @question = @quiz.questions.build
    authorize @question
    @question_choices = Array.new(2) { @question.choices.build }
  end

  def create
    @question = Question.new(question_params)
    authorize @question
    if @question.save
      flash[:notice] = t("flash.questions.create.success")
      respond_to do |format|
        format.html { redirect_to author_quiz_url(@quiz) }
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
      # FIX: Flash not showing
      flash.now[:notice] = t("flash.questions.destroy.success")
    else
      flash.now[:error] = t("flash.questions.destroy.error")
    end

    redirect_to author_quiz_url(@question.quiz)
  end

  private

  def authorize_access!
    authorize @question
  end

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:quiz_id, :content, choices_attributes: %i[id content correct])
  end

  def set_breadcrumbs
    add_breadcrumb("Design")
    if @quiz&.author_id.present?
      add_breadcrumb("Quizzes", author_quizzes_path)
      add_breadcrumb(@quiz.title, author_quiz_path(@quiz))
    end
    add_breadcrumb(@question.content, quiz_question_path(@quiz, @question)) if form_render?
  end

  def form_render?
    [ :edit ].include?(params[:action].to_sym)
  end
end
