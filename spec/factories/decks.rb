FactoryBot.define do
  factory :deck do
    title { "#{Faker::Lorem.sentence(word_count: 2)} Deck" }
    description { Faker::Lorem.paragraph }
    author { create(:user) }
  end
end
