module StudyPlans
  class QuizzesController < ApplicationController
    before_action :set_study_plan

    def create
      @study_plan = authorize(@study_plan, policy_class: Users::StudyPlanPolicy)
      quiz = Quiz.find(quiz_params[:quiz_id])
      @study_plan.quizzes << quiz unless @study_plan.quizzes.include?(quiz)

      flash.now[:notice] = "Quiz was successfully added to your study plan."
      redirect_back(fallback_location: user_study_plan_path(current_user, @study_plan))
    end

    def destroy; end

    private

      def quiz_params
        params.require(:quiz).permit(:quiz_id)
      end

      def set_study_plan
        @study_plan = StudyPlan.find(params[:study_plan_id])
      end
  end
end
