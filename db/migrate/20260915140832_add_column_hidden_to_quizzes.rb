class AddColumnHiddenToQuizzes < ActiveRecord::Migration[7.2]
  def change
    add_column :quizzes, :hidden, :boolean, default: false, null: false
  end
end
