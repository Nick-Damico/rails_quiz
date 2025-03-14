class UserDeckCardsController < ApplicationController
  before_action :set_user_deck_card, only: []


  private

    def set_user_deck_card
      @user_deck_card = UserDeckCard.find(params[:id])
    end
end
