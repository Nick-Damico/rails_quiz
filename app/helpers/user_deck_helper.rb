module UserDeckHelper
  def first_card(card, ids)
    ids.first == card.id
  end

  def last_card(card, ids)
    ids.last == card.id
  end

  def prev_card_id(card, ids)
    ids[id_index(card.id, ids) - 1]
  end

  def next_card_id(card, ids)
    next_id(card.id, ids)
  end
end
