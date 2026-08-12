module Author
  class QuizzesController < ApplicationController
    before_action :set_quiz, only: %i[destroy edit publish show update]
    before_action :set_author, only: %i[create destroy edit index new show]
    before_action :set_categories, only: %i[create edit new update]
    before_action :set_breadcrumbs
    before_action :authorize_access!, except: %i[create index new]

    def index
      search = QuizSearch.new(policy_scope([ :author, Quiz ]), params)

      @filter_options = search.filter_options
      @pagy, @quizzes = pagy(
        :countish, search.query.order(:title, :created_at)
      )
    end

    def show; end

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
        render :new, status: :unprocessable_content
      end
    end

    def edit
    end

    def update
      if @quiz.update(quiz_params)
        flash[:notice] = t("flash.quizzes.update.success")
        redirect_to author_quiz_url(@quiz)
      else
        @author = @quiz.author
        flash[:alert] = t("flash.quizzes.update.error")
        render :edit, status: :unprocessable_content
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

    def publish
      authorize([ :author, @quiz ])
      publish = params.dig(:quiz, :publish) == "1"

      if publish && !@quiz.published? && @quiz.publish!
        flash[:notice] = t("flash.quizzes.publish.success")
      elsif !publish && @quiz.published? && @quiz.unpublish!
        flash[:notice] = t("flash.quizzes.unpublish.success")
      else
        flash[:alert] = @quiz.errors.full_messages
      end

      redirect_to author_quiz_url(@quiz), status: :see_other
    end

    private

      def authorize_access!
        authorize([ :author, @quiz ])
      end

      def record_not_found_redirect_url
        author_quizzes_url
      end

      def unauthorized_redirect_url
        author_quizzes_url
      end

      def quiz_params
        params.require(:quiz).permit(:title, :description, :author_id, :category_id)
      end

      def set_author
        @author = current_user
      end

      def set_categories
        @categories = Category.all.order(:name)
      end

      def set_quiz
        @quiz = Quiz.find(params[:id])
      end

      def set_breadcrumbs
        add_breadcrumb("Home", root_path)
        add_breadcrumb("Design")
        add_breadcrumb("Quizzes", author_quizzes_path) if @author.present?
        add_breadcrumb(@quiz.title, author_quiz_path(@quiz)) if @quiz.present?
      end
  end
end
