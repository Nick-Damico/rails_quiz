class AddColumnUseSpaceRepetitionToUserDecks < ActiveRecord::Migration[7.2]
  def change
    add_column :user_decks, :use_space_repetition, :boolean, default: false
  end
end
