class Author::DecksController < ApplicationController
  def index
    @decks = policy_scope([ :author, Deck ])
  end
end
