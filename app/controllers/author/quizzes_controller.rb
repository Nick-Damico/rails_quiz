module Author
  class QuizzesController < ApplicationController
    before_action :set_quiz, only: %i[destroy edit show update]
    before_action :set_author, only: %i[create destroy edit index new show]
    before_action :set_breadcrumbs
    before_action :authorize_access!, except: %i[create index new]

    def index
      @quizzes = policy_scope(Quiz, policy_scope_class: QuizPolicy::Scope)
    end

    def show
    end

    def new
      @quiz = authorize([ :author, @author.authored_quizzes.new ])
    end

    def create
      @quiz = authorize([ :author, @author.authored_quizzes.new(quiz_params) ])
      if @quiz.save
        flash[:notice] = t("flash.quizzes.create.success")
        redirect_to author_quiz_url(@quiz)
      else
        flash.now[:alert] = t("flash.quizzes.create.error")
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @quiz.update(quiz_params)
        flash[:notice] = t("flash.quizzes.update.success")
        redirect_to author_quiz_url(@quiz)
      else
        # TODO: Display attirbutes and error messages on forms
        @author = @quiz.author
        flash[:alert] = t("flash.quizzes.update.error")
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @quiz.destroy
        flash[:notice] = t("flash.quizzes.destroy.success")
        redirect_to author_quizzes_url
      else
        flash[:alert] = t("flash.quizzes.destroy.error")
        redirect_to author_quizzes_url
      end
    end

    private

    def authorize_access!
      authorize([ :author, @quiz ])
    end

    def quiz_params
      params.require(:quiz).permit(:title, :description, :author_id)
    end

    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    def set_author
      @author = current_user
    end

    def set_breadcrumbs
      add_breadcrumb("Design")
      add_breadcrumb("Quizzes", author_quizzes_path) if @author.present?
      add_breadcrumb(@quiz.title, author_quiz_path(@quiz)) if @quiz.present?
    end
  end
end
