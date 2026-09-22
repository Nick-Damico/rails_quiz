class Admin::DecksController < Admin::BaseController
  before_action :set_deck, except: %i[index]

  def index
    default_scope = policy_scope([ :admin, Deck.all ])
    search = UserSearch.new(default_scope, params)

    @tab = "deck"
    @user = current_user # maybe remove
    @pagy, decks = pagy(:countish, search.query)
    @decks = decks.map { |deck| Admin::DeckPresenter.new(deck) }
    # navigation tabs
    @deck_count = Deck.count
    @quiz_count = Quiz.count
    @user_count = User.count
  end

  def edit; end

  def update
    if @deck.update(deck_params)
      if @deck.hidden?
        @deck.unpublish! if @deck.published?
        flash[:notice] = "deck deactivated successfully"
      else
        flash[:notice] = "deck updated successfully"
      end

      redirect_to admin_dashboard_url(tab: "deck")
    else
      flash.now[:alert] = @deck.errors.full_messages
      render :edit, status: :unprocessable_content
    end
  end

  private

    def deck_params
      params.require(:deck).permit(:title, :description, :hidden)
    end

    def authorize_admin!
      authorize [ :admin, :deck ], :access?
    end

    def set_deck
      @deck = Deck.find(params[:id])
    end
end
