module UserDeckHelper
  def card_number(user_deck_card, ids)
    id_index(user_deck_card.id, ids) + 1
  end

  def first_card(user_deck_card, ids)
    ids.first == user_deck_card.id
  end

  def last_card(user_deck_card, ids)
    ids.last == user_deck_card.id
  end

  def prev_card_id(user_deck_card, ids)
    ids[id_index(user_deck_card.id, ids) - 1]
  end

  def next_card_id(user_deck_card, ids)
    next_id(user_deck_card.id, ids)
  end
end
