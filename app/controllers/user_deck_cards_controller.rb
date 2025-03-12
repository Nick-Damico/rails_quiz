class UserDeckCardsController < ApplicationController
  before_action :set_user_deck_card, only: [ :show ]
  def show
    # TODO: Set instance variables for show view partial rendering of review_card
    @user_deck_card = authorize(@user_deck_card)
    respond_to do |format|
      format.html { redirect_to user_deck_url(@user_deck_card.user_deck, card_id: @user_deck_card.id) }
    end
  end

  private

    def set_user_deck_card
      @user_deck_card = UserDeckCard.find(params[:id])
    end
end
