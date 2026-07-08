class StudyPlanDecksController < ApplicationController
  before_action :set_study_plan, only: %i[create]

  def create
    @study_plan = authorize([ :users, @study_plan ])
    @study_plan_deck = @study_plan.study_plan_decks.new(study_plan_deck_params)

    if @study_plan_deck.save
      flash.now[:notice] = t("flash.study_plan_decks.create.success")
      redirect_to user_study_plan_url(current_user, @study_plan)
    else
      flash.now[:alert] = t("flash.study_plan_decks.create.error")
    end
  end

  private

    def set_study_plan
      @study_plan = StudyPlan.find(
        params.dig(:study_plan_deck, :study_plan_id)
      )
    end

    def study_plan_deck_params
      params.require(:study_plan_deck).permit(:study_plan_id, :deck_id)
    end
end
