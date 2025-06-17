class DecksController < ApplicationController
  before_action :set_deck, only: %i[show]
  before_action :set_breadcrumbs, only: %i[index show]
  def index
    @decks = policy_scope(Deck)
  end

  def show
    @deck = authorize(@deck)
  end

  private

    def set_breadcrumbs
      add_breadcrumb "Study"
      add_breadcrumb "Decks", decks_path
      if @deck.present?
        add_breadcrumb @deck.title, nil
      end
    end

    def set_deck
      @deck = Deck.find(params[:id])
    end
end
