class Admin::QuizzesController < Admin::BaseController
  before_action :set_quiz

  def edit; end

  def update
    if @quiz.update(quiz_params)
      if @quiz.hidden?
        @quiz.unpublish! if @quiz.published?
        flash[:notice] = "quiz deactivated successfully"
      else
        flash[:notice] = "quiz updated successfully"
      end

      redirect_to admin_dashboard_url(tab: "quiz")
    else
      flash.now[:alert] = @quiz.errors.full_messages
      render :edit, status: :unprocessable_content
    end
  end

  private

    def quiz_params
      params.require(:quiz).permit(:title, :description, :hidden)
    end

    def authorize_admin!
      authorize [ :admin, :quiz ], :access?
    end

    def set_quiz
      @quiz = Quiz.find(params[:id])
    end
end
