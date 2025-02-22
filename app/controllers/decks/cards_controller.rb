class Decks::CardsController < ApplicationController
  before_action :set_deck, only: %i[new create]
  before_action :set_card, only: %i[show]
  before_action :set_breadcrumbs, only: %i[new create]


  def show
    @card = authorize(@card)
  end

  def new
    @card = authorize(@deck.cards.new)
  end

  def create
    @card = authorize(@deck.cards.new(card_params))

    if @card.save
      flash[:notice] = t("flash.cards.create.success")
      if params[:follow_up_action].nil? || params[:follow_up_action] == "new"
        redirect_to new_deck_card_url(deck_id: @deck.id)
      elsif params[:follow_up_action] == "show"
        redirect_to author_deck_url(@deck)
      end
    else
      flash.now[:alert] = t("flash.cards.create.error")
      render :new, status: :unprocessable_entity
    end
  end


  private

    def card_params
      params.require(:card).permit(:front, :back, :deck_id)
    end

    def set_card
      @card = Decks::Card.find(params[:id])
    end

    def set_breadcrumbs
      add_breadcrumb("Design")
      add_breadcrumb("Decks", author_decks_path)
      if @deck
        add_breadcrumb(@deck.title, author_deck_path(@deck))
      end
    end

    def set_deck
      @deck = Deck.includes(:cards).find(params[:deck_id])
    end
end
