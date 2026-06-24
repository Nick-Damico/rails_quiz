class DecksController < ApplicationController
  before_action :set_deck, only: %i[show]
  before_action :set_breadcrumbs, only: %i[index show]
  def index
    @pagy, @decks = pagy(:countish, policy_scope(Deck).order(:title, :created_at))
  end

  def show
    @deck = authorize(@deck)
    @user_deck = current_user.user_decks.find_or_initialize_by(deck: @deck)
    @due_for_review_count = @user_deck.cards_for_review.count
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
