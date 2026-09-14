class AddColumnHiddenToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :hidden, :boolean, default: false
  end
end
