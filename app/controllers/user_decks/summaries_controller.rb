class UserDecks::SummariesController < ApplicationController
  before_action :set_user_deck, only: [ :show ]

  def show
    authorize(@user_deck)
  end

  private

    def set_user_deck
      @user_deck = UserDeck.find(params[:user_deck_id])
    end
end
