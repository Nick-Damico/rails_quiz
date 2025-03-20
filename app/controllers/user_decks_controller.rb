class UserDecksController < ApplicationController
  before_action :set_user, only: %i[create]
  before_action :set_user_deck, only: %i[show update]

  def show
    @user_deck = authorize(@user_deck)

    set_breadcrumbs
    @user_deck_card = @user_deck.find_card_with_fallback(params[:card_id])
    @user_deck_card_ids = @user_deck.user_deck_card_ids
  end

  def create
    @user_deck = authorize(UserDeck.new(user_deck_params))
    @user_deck.build_user_cards

    if @user_deck.save
      flash[:notice] = t("flash.user_decks.create.success")
      redirect_to @user_deck
    else
      flash[:alert] = t("flash.user_decks.create.error")
      redirect_back_or_to(decks_url)
    end
  end

  def update
    # TODO: Save Results at some point
    authorize(@user_deck)
    if @user_deck.save
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
      params.require(:user_deck).permit(:user_id, :deck_id)
    end

    def set_user
      @user = current_user
    end

    def set_user_deck
      @user_deck = UserDeck.includes(:user_deck_cards).find(params[:id])
    end
end
