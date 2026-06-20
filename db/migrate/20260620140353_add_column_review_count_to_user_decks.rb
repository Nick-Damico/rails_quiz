class AddColumnReviewCountToUserDecks < ActiveRecord::Migration[7.2]
  def change
    add_column :user_decks, :review_count, :integer
  end
end
