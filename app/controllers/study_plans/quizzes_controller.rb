module StudyPlans
  class QuizzesController < ApplicationController
    before_action :set_study_plan

    def create
      @study_plan = authorize(@study_plan, policy_class: Users::StudyPlanPolicy)
      if (@quiz = Quiz.find_by_id(quiz_params[:quiz_id]))
        @study_plan.quizzes << @quiz unless @study_plan.quizzes.include?(@quiz)
        flash.now[:notice] = t("flash.study_plans.quizzes.create.success")
        redirect_back(fallback_location: user_study_plan_path(current_user, @study_plan))
      else
        flash[:alert] = t("flash.study_plans.quizzes.create.error")
        render "users/study_plans/show", status: :unprocessable_entity
      end
    end

    def destroy
      authorize(@study_plan, policy_class: Users::StudyPlanPolicy)
      quiz = Quiz.find_by_id(params[:id])
      if @study_plan.quizzes.include?(quiz)
        @study_plan.quizzes.delete(quiz)
        flash.now[:notice] = t("flash.study_plans.quizzes.destroy.sucess", quiz_title: quiz.title)
      else
        flash.now[:alert] = t("flash.study_plans.quizzes.destroy.error")
      end
      redirect_back(fallback_location: user_study_plan_path(current_user, @study_plan))
    end

    private

      def quiz_params
        params.require(:quiz).permit(:quiz_id)
      end

      def set_study_plan
        @study_plan = StudyPlan.find(params[:study_plan_id])
      end
  end
end
