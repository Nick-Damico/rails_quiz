class AddRankToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :rank, :integer, default: 0

    add_index :users, :rank
  end
end
