class DecksController < ApplicationController
  before_action :set_deck, only: %i[show]
  def index
    @decks = policy_scope(Deck)
  end

  def show
    add_breadcrumb "Study"
    add_breadcrumb "Decks", decks_path
    add_breadcrumb @deck.title, nil
    @deck = authorize(@deck)
  end

  private

    def set_deck
      @deck = Deck.find(params[:id])
    end
end
