class UpdateUsersNameToUsername < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :name, :username
  end
end
