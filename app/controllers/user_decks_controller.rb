# This file represents a User reviewing a deck of cards.
# When a user starts a review, a UserDeck is created.

class UserDecksController < ApplicationController
  before_action :set_user, only: %i[create]
  before_action :set_user_deck, only: %i[show update]

  # TODO: Revisit review card selection workflow.
  #
  # Questions:
  # - Is #find_card_with_fallback still necessary, or can it be removed?
  # - Move card selection/query logic out of the controller and into UserDeck.
  #
  # Goal:
  # - Reduce controller responsibility and centralize review card logic.
  # - replace with something like `UserDeck#review_cards`
  def show
    @user_deck = authorize(@user_deck)

    set_breadcrumbs
    if @user_deck.use_space_repetition?
      @user_deck_cards = UserDeckCard.due_for_review(@user_deck).order(:id)
    else
      @user_deck_cards = UserDeckCard.by_user_deck(@user_deck).order(:id)
    end
    @user_deck_card = @user_deck.find_card_with_fallback(
      params[:card_id], user_deck_cards: @user_deck_cards
    )

    @user_deck_card_ids = @user_deck_cards.pluck(:id)
  end

  def create
    @user_deck = UserDeck.find_or_initialize_by(
      user_id: user_deck_params[:user_id], deck_id: user_deck_params[:deck_id]
    )
    @user_deck.assign_attributes(user_deck_params)
    @user_deck = authorize(@user_deck)

    if @user_deck.persisted? && @user_deck.no_review_due?
      redirect_back_or_to(
        @user_deck.deck,
        notice: t("flash.user_decks.no_review_due")
      )
      return
    end

    @user_deck.prepare_for_review

    if @user_deck.save
      @user_deck.mark_started
      flash[:notice] = t("flash.user_decks.create.success")
      redirect_to @user_deck
    else
      flash[:alert] = t("flash.user_decks.create.error")
      redirect_back_or_to(decks_url)
    end
  end

  def update
    authorize(@user_deck)
    if @user_deck.save
      @user_deck.mark_completed
      redirect_to user_deck_summary_url(@user_deck)
    end
  end

  private

    def set_breadcrumbs
      add_breadcrumb("Study")
      add_breadcrumb("Decks", decks_path)
      add_breadcrumb(@user_deck.deck.title, deck_path(@user_deck.deck))
      add_breadcrumb("Review")
    end

    def user_deck_params
      params.require(:user_deck).permit(:user_id, :deck_id, :use_space_repetition)
    end

    def set_user
      @user = current_user
    end

    def set_user_deck
      @user_deck = UserDeck.includes(:user_deck_cards).find(params[:id])
    end
end
