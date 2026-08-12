class DecksController < ApplicationController
  before_action :set_deck, only: %i[show]
  before_action :set_breadcrumbs, only: %i[index show]
  def index
    default_scope = policy_scope(Deck).published

    search = DeckSearch.new(default_scope, params)

    @filter_options = search.filter_options
    @pagy, @decks = pagy(:countish, search.query.order(:title, :created_at))
  end

  def show
    @deck = authorize(@deck)
    @user_deck = current_user.user_decks.find_or_initialize_by(deck: @deck)
    @due_for_review_count = @user_deck.cards_for_review.count
    @study_plans = StudyPlan.where(user: current_user).order(:name)
  end

  private

    def set_breadcrumbs
      add_breadcrumb("Home", root_path)
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
