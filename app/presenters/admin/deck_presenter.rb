class Admin::DeckPresenter
  attr_reader :deck

  def initialize(deck)
    @deck = deck
  end

  def to_model
    deck
  end

  def id
    deck.id
  end

  def title
    deck.title
  end

  def author
    deck.author
  end

  def author_name
    deck.author.username
  end

  def created_on
    deck.created_at.strftime("%Y-%m-%d")
  end
end
