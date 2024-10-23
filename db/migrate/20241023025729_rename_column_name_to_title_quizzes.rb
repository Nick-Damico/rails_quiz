class RenameColumnNameToTitleQuizzes < ActiveRecord::Migration[7.2]
  def change
    rename_column :quizzes, :name, :title
  end
end
