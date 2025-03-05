FactoryBot.define do
  factory :user_deck do
    user { create(:user) }
    deck { create(:deck) }
  end
end
