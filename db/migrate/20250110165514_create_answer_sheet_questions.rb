class CreateAnswerSheetQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :answer_sheet_questions do |t|
      t.references :answer_sheet, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :answer, null: true, foreign_key: { to_table: :question_choices }

      t.timestamps
    end
  end
end
