class CreateQuestionChoices < ActiveRecord::Migration[7.2]
  def change
    create_table :question_choices do |t|
      t.text :content
      t.boolean :correct, null: false, default: false
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
