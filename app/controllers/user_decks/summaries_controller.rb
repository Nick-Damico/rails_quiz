class UserDecks::SummariesController < ApplicationController
  before_action :set_user_deck, only: [ :show ]

  def show
    authorize(@user_deck, policy_class: UserDecks::SummaryPolicy)

    @active_tab = "graph"
    @chart_data =
      UserDeckCard.group_by_rating(@user_deck)
                  .where(card_rating: %w[incorrect correct])
                  .order(card_rating: :desc)
                  .count

    unless @user_deck.completed?
      flash[:alert] = t("flash.user_decks.summaries.show.error")
      redirect_to deck_url(@user_deck.deck) and return
    end
  end

  private

    def set_user_deck
      @user_deck = UserDeck.find(params[:user_deck_id])
    end
end
