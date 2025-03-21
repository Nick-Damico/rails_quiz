FactoryBot.define do
  factory :user_deck do
    user { create(:user) }
    deck { create(:deck, card_count: 2) }

    trait :with_user_deck_cards do
      after(:create) do |user_deck|
        user_deck.build_user_cards
        user_deck.save!
      end
    end

    trait :with_completed do
      after(:create) do |user_deck|
        user_deck.mark_started
        user_deck.update_column(:completed_at, Time.current.utc + 5.minutes)
      end
    end
  end
end
