class Author::DecksController < ApplicationController
  before_action :set_author
  before_action :set_deck, only: %i[show edit]
  # set breadcrumbs last
  before_action :set_breacrumbs, only: %i[index show]
  def index
    @decks = policy_scope([ :author, Deck ])
  end

  def show
    authorize([ :author, @deck ])
  end

  def new
    @deck = authorize([ :author, @author.authored_decks.new ])
  end

  def create
    @deck = authorize([ :author, Deck.new(deck_params) ])
    if @deck.save
      flash[:notice] = t("flash.decks.create.success")
      redirect_to [ :author, @deck ]
    else
      flash.now[:alert] = t("flash.decks.create.error")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize([ :author, @deck ])
  end

  private

  def deck_params
    params.require(:deck).permit(:title, :description, :author_id)
  end

  def set_author
    @author = current_user
  end

  def set_deck
    @deck = Deck.find(params[:id])
  end

  def set_breacrumbs
    add_breadcrumb("Design")
    add_breadcrumb("Flashcard Decks", author_decks_path)
    if @deck
      add_breadcrumb(@deck.title, author_deck_path(@deck))
    end
  end
end
