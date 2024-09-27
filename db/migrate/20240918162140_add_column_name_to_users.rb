class AddColumnNameToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string
    add_index :users, :name
  end
end
