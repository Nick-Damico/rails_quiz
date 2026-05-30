class UserDeckCardsController < ApplicationController
  before_action :set_user_deck_card, only: %i[update]

  def index
    rating = safe_params[:card_rating].presence_in(UserDeckCard.card_ratings.keys)

    @user_deck_cards =
      policy_scope(UserDeckCard).where(
        card_rating: rating,
        user_decks: { deck_id: safe_params[:deck_id] }
      )
  end

  def update
    authorize @user_deck_card

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
