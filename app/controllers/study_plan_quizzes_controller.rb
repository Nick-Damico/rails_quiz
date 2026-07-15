class StudyPlanQuizzesController < ApplicationController
  before_action :set_quiz, only: %i[create]
  before_action :set_study_plan, only: %i[create]

  def create
    study_plan = authorize([ :users, @study_plan ])
    if study_plan.quizzes.include?(@quiz)
      flash[:alert] = t("flash.study_plan_quizzes.create.already_exists")
      redirect_to quiz_url(@quiz) and return
    end

    study_plan_quiz = study_plan.study_plan_quizzes.new(study_plan_quiz_params)

    if study_plan_quiz.save
      flash[:notice] = t("flash.study_plan_quizzes.create.success")
      redirect_to user_study_plan_url(current_user, @study_plan)
    else
      flash.now[:alert] = t("flash.study_plan_quizzes.create.error")
      redirect_to quiz_url(@quiz)
    end
  end

  def destroy
    study_plan_quiz = StudyPlanQuiz.find(params[:id])
    study_plan = authorize([ :users, study_plan_quiz.study_plan ])

    if study_plan_quiz.destroy
      flash[:notice] = t("flash.study_plan_quizzes.destroy.success")
      redirect_to user_study_plan_url(current_user, study_plan)
    end
  end

  private

    def set_quiz
      @quiz = Quiz.find(params.dig(:study_plan_quiz, :quiz_id))
    end

    def set_study_plan
      @study_plan = StudyPlan.find(
        params.dig(:study_plan_quiz, :study_plan_id)
      )
    end

    def study_plan_quiz_params
      params.require(:study_plan_quiz).permit(:study_plan_id, :quiz_id)
    end
end
