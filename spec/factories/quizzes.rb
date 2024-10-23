FactoryBot.define do
  factory :quiz do
    author { create(:user) }
    title { "#{Faker::Lorem.sentence(word_count: 3)} Quiz" }
    description { Faker::Lorem.paragraph }
  end
end
