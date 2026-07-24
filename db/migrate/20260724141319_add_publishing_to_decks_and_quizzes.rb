class AddPublishingToDecksAndQuizzes < ActiveRecord::Migration[7.2]
  def change
    add_column :decks, :published_at, :datetime, null: true
    add_column :quizzes, :published_at, :datetime, null: true
  end
end
