class CreateStudyPlanDecks < ActiveRecord::Migration[7.2]
  def change
    create_table :study_plan_decks do |t|
      t.references :study_plan, null: false, foreign_key: true
      t.references :deck, null: false, foreign_key: true

      t.timestamps
    end

    add_index :study_plan_decks, %i[study_plan_id deck_id], unique: true, name: 'index_study_plan_decks_on_study_plan_and_deck'
  end
end
