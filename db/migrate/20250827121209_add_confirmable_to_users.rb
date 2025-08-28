class AddConfirmableToUsers < ActiveRecord::Migration[7.2]
  def self.up
    ## Confirmable
    # t.string   :confirmation_token
    add_column :users, :confirmation_token, :string
    # t.datetime :confirmed_at
    add_column :users, :confirmed_at, :datetime
    # t.datetime :confirmation_sent_at
    add_column :users, :confirmation_sent_at, :datetime
    # t.string   :unconfirmed_email # Only if using reconfirmable
    add_column :users, :unconfirmed_email, :string

    add_index :users, :confirmation_token,   unique: true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
