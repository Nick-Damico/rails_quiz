class CreateUserDeckCards < ActiveRecord::Migration[7.2]
  def change
    create_table :user_deck_cards do |t|
      t.references :user_deck, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
