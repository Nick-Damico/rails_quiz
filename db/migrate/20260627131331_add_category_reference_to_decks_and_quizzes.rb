class AddCategoryReferenceToDecksAndQuizzes < ActiveRecord::Migration[7.2]
  def change
    add_reference :decks, :category, foreign_key: true
    add_reference :quizzes, :category, foreign_key: true
  end
end
