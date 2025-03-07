FactoryBot.define do
  factory :user_deck do
    user { create(:user) }
    deck { create(:deck, card_count: 2) }
  end
end
