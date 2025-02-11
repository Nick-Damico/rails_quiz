class CreateCard < ActiveRecord::Migration[7.2]
  def change
    create_table :cards do |t|
      t.text :front, null: false
      t.text :back, null: false
      t.references :deck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
