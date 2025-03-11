class UserDeckCardsController < ApplicationController
  before_action :set_user_deck_card, only: [ :show ]
  def show
    @user_deck_card = authorize(@user_deck_card)
  end

  private

    def set_user_deck_card
      @user_deck_card = UserDeckCard.find(params[:id])
    end
end
