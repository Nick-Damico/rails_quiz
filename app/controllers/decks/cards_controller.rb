class Decks::CardsController < ApplicationController
  before_action :set_deck, only: %i[new]
  before_action :set_card, only: %i[show]
  before_action :set_breadcrumbs, only: %i[new]

  def new
    @card = authorize(@deck.cards.new)
  end

  def show
    @card = authorize(@card)
  end

  private

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
      @deck = Deck.find(params[:deck_id])
    end
end
