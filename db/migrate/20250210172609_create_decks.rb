class CreateDecks < ActiveRecord::Migration[7.2]
  def change
    create_table :decks do |t|
      t.string :title, null: false
      t.text :description
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
