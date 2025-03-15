class AddRatingToUserDeckCards < ActiveRecord::Migration[7.2]
  def change
    add_column :user_deck_cards, :card_rating, :integer, default: 0

    add_index :user_deck_cards, :card_rating
  end
end
