task clear_user_deck_card_ratings!: [ :environment ] do
  UserDeckCard.update_all(card_rating: :not_rated)
end
