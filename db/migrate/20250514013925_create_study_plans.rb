class CreateStudyPlans < ActiveRecord::Migration[7.2]
  def change
    create_table :study_plans do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
