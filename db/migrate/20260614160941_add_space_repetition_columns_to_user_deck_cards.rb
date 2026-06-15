class AddSpaceRepetitionColumnsToUserDeckCards < ActiveRecord::Migration[7.2]
  def change
    # The ease factor determines how quickly the interval between reviews increases. It starts at 2.5 and is adjusted based on the user's performance.
    add_column :user_deck_cards, :ease_factor, :decimal, precision: 4, scale: 2, default: 2.5
    # The datetime stamp of the next review session for the card.
    add_column :user_deck_cards, :next_review_at, :datetime
    # The number of times the card has been successfully reviewed. Resets on a failed review.
    add_column :user_deck_cards, :successful_reviews, :integer, default: 0
    # The number of days until the next review. This is stored because you would need to recalculate the entire review history each time to calculate the :next_review_at datetime.
    add_column :user_deck_cards, :interval_days, :integer, default: 0
  end
end
