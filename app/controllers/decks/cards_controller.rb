class Decks::CardsController < ApplicationController
  before_action :set_deck, only: %i[new]
  before_action :set_card, only: %i[show]

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

    def set_deck
      @deck = Deck.find(params[:deck_id])
    end
end
