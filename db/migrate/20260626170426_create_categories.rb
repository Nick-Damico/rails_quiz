class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.string :name, index: { unique: true }
      t.string :slug, index: { unique: true }

      t.timestamps
    end
  end
end
