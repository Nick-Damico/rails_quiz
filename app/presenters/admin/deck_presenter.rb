class Admin::DeckPresenter
  attr_reader :deck

  delegate :id, :to_model, :author, :title, :hidden?, :published?, to: :deck

  def initialize(deck)
    @deck = deck
  end

  def to_param
    String(deck.id)
  end

  def author_name
    deck.author.username
  end

  def created_on
    deck.created_at.strftime("%Y-%m-%d")
  end
end
