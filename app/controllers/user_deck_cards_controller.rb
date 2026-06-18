class UserDeckCardsController < ApplicationController
  before_action :set_user_deck_card, only: %i[update]

  def index
    @user_deck = policy_scope(UserDeck).find_by(deck_id: safe_params[:deck_id])
    authorize @user_deck, :show?

    rating = safe_params[:card_rating].presence_in(UserDeckCard.card_ratings.keys)
    @user_deck_cards =
      policy_scope(UserDeckCard).joins(:user_deck).where(
        card_rating: rating,
        user_decks: { id: @user_deck.id }
      )
    @active_tab = rating # sets nav tab to active
  end

  def update
    authorize @user_deck_card

    if @user_deck_card.user_deck.use_space_repetition?
      @user_deck_card.calculate_next_recall(user_deck_card_params[:card_rating])
    end

    if @user_deck_card.update(user_deck_card_params)
      render json: { rating: @user_deck_card.card_rating }, status: :ok
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  private

    def user_deck_card_params
      params.require(:user_deck_card).permit(:card_rating)
    end

    def set_user_deck_card
      @user_deck_card = UserDeckCard.find(params[:id])
    end

    def safe_params
      params.permit(:card_rating, :deck_id)
    end
end
