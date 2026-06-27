class AddNullOptionToCategories < ActiveRecord::Migration[7.2]
  def change
    change_column_null :decks, :category_id, false
    change_column_null :quizzes, :category_id, false
  end
end
