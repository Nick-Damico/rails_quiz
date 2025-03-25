class AddIndexUserDeckAndCardRatingToUserDeckCards < ActiveRecord::Migration[7.2]
  def change
    add_index :user_deck_cards, [ :user_deck_id, :card_rating ]
  end
end
