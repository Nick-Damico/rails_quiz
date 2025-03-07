FactoryBot.define do
  factory :user_deck_card do
    user_deck { create(:user_deck) }

    after(:build) do |user_deck_card|
      user_deck_card.card = user_deck_card.user_deck.deck.cards.first
    end
  end
end
