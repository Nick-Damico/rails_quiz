class CreateStudyPlanQuizzes < ActiveRecord::Migration[7.2]
  def change
    create_table :study_plan_quizzes do |t|
      t.references :study_plan, null: false, foreign_key: true
      t.references :quiz, null: false, foreign_key: true

      t.timestamps
    end

    add_index :study_plan_quizzes, %i[study_plan_id quiz_id], unique: true, name: 'index_study_plan_quizzes_on_study_plan_and_quiz'
  end
end
