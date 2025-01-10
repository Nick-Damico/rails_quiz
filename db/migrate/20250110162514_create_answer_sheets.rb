class CreateAnswerSheets < ActiveRecord::Migration[7.2]
  def change
    create_table :answer_sheets do |t|
      t.references :quiz, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :grade, scale: 5, precision: 2

      t.timestamps
    end
  end
end
