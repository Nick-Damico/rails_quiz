class StudyPlanDecksController < ApplicationController
  before_action :set_deck, only: %i[create]
  before_action :set_study_plan, only: %i[create]

  def create
    study_plan = authorize([ :users, @study_plan ])
    if study_plan.decks.include?(@deck)
      flash[:alert] = t("flash.study_plan_decks.create.already_exists")
      redirect_to deck_url(@deck) and return
    end

    study_plan_deck = study_plan.study_plan_decks.new(study_plan_deck_params)

    if study_plan_deck.save
      flash[:notice] = t("flash.study_plan_decks.create.success")
      redirect_to user_study_plan_url(current_user, @study_plan)
    else
      flash.now[:alert] = t("flash.study_plan_decks.create.error")
      redirect_to deck_url(@deck)
    end
  end

  def destroy
    study_plan_deck = StudyPlanDeck.find(params[:id])
    study_plan = authorize([ :users, study_plan_deck.study_plan ])

    if study_plan_deck.destroy
      flash[:notice] = t("flash.study_plan_decks.destroy.success")
      redirect_to user_study_plan_url(current_user, study_plan)
    else
      flash[:alert] = t("flash.study_plan_decks.destroy.error")
      redirect_to user_study_plan_url(current_user, study_plan)
    end
  end

  private

    def set_deck
      @deck = Deck.find(params.dig(:study_plan_deck, :deck_id))
    end

    def set_study_plan
      @study_plan = StudyPlan.find(
        params.dig(:study_plan_deck, :study_plan_id)
      )
    end

    def study_plan_deck_params
      params.require(:study_plan_deck).permit(:study_plan_id, :deck_id)
    end
end
