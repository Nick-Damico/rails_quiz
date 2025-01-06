module Author
  class QuizzesController < ApplicationController
    before_action :set_quiz, only: %i[destroy edit show update]
    before_action :set_author, only: %i[create destroy edit index new show]
    before_action :set_breadcrumbs

    def index
      @quizzes = @author.authored_quizzes
    end

    def show
    end

    def new
      @quiz = @author.authored_quizzes.new
    end

    def create
      @quiz = @author.authored_quizzes.new(quiz_params)
      if @quiz.save
        flash[:notice] = t("flash.quizzes.create.success")
        redirect_to author_quizzes_url
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
        redirect_to quizzes_url(author_id: @quiz.author)
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
        redirect_to quizzes_url(author_id: @author)
      else
        flash[:alert] = t("flash.quizzes.destroy.error")
        redirect_to quizzes_url(author_id: @author)
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
      @author = current_user
    end

    def set_breadcrumbs
      add_breadcrumb("Home", quizzes_path(author_id: @author.id)) if @author.present?
      add_breadcrumb(@quiz.title, quiz_path(@quiz, author_id: @quiz.author_id)) if @quiz.present?
    end
  end
end
