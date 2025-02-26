class Decks::CardsController < ApplicationController
  before_action :set_deck, only: %i[new create]
  before_action :set_card, only: %i[show edit update]
  before_action :set_breadcrumbs, only: %i[new create]

  def show
    @card = authorize(@card)
  end

  def new
    @card = authorize(@deck.cards.new)
  end

  def create
    @card = authorize(@deck.cards.new(card_params))
    unless @card.save
      flash.now[:alert] = t("flash.cards.create.error")
      return render :new, status: :unprocessable_entity
    end

    flash[:notice] = t("flash.cards.create.success")
    handle_follow_up_action(@deck, params[:follow_up_action])
  end

  def edit
    @card = authorize(@card)
    @deck = @card.deck
    set_breadcrumbs
  end

  def update
    @card.assign_attributes(card_params)
    @card = authorize(@card)
    @deck = @card.deck

    set_breadcrumbs
    unless @card.save
      flash.now[:alert] = t("flash.cards.update.error")
      render :edit, status: :unprocessable_entity and return
    end

    flash[:notice] = t("flash.cards.update.success")
    handle_follow_up_action(@card.deck, params[:follow_up_action])
  end

  private

    def card_params
      params.require(:card).permit(:front, :back, :deck_id)
    end

    def handle_follow_up_action(deck, follow_up_action)
      case follow_up_action
      when "new"
        redirect_to new_deck_card_url(deck_id: deck.id)
      when "show"
        redirect_to author_deck_url(deck)
      else
        redirect_to new_deck_card_url(deck_id: deck.id)
      end
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

      if form_render?
        add_breadcrumb("#{params[:action].capitalize} Card")
      end
    end

    def set_deck
      @deck = Deck.includes(:cards).find(params[:deck_id])
    end
end
