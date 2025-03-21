class AddStartedAtToUserDecks < ActiveRecord::Migration[7.2]
  def change
    add_column :user_decks, :started_at, :datetime, null: true
    add_column :user_decks, :completed_at, :datetime, null: true
  end
end
