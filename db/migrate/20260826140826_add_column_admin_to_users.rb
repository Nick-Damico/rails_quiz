class AddColumnAdminToUsers < ActiveRecord::Migration[7.2]
  def change
    create_enum :user_role, %w[admin user]

    add_column :users, :role, :user_role, default: "user", null: false
  end
end
