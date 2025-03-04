FactoryBot.define do
  factory :deck do
    title { "#{Faker::Lorem.sentence(word_count: 2)} Deck" }
    description { Faker::Lorem.paragraph }
    author { create(:user) }

    transient do
      card_count { 0 }
    end

    after(:create) do |deck, evaluator|
      create_list(:card, evaluator.card_count, deck:)
    end
  end


  trait :with_cards do
    transient { card_count { 2 } }
  end
end
