class Author::DecksController < ApplicationController
  before_action :set_breacrumbs, only: %i[index]
  def index
    @decks = policy_scope([ :author, Deck ])
  end

  private

  def set_breacrumbs
    add_breadcrumb("Design")
    add_breadcrumb("Flashcard Decks", author_decks_path)
  end
end
