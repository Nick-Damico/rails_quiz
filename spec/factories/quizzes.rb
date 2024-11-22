FactoryBot.define do
  factory :quiz do
    author { create(:user) }
    title { "#{Faker::Lorem.sentence(word_count: 3)} Quiz" }
    description { Faker::Lorem.paragraph }

    trait :with_questions do
     after(:create) do |quiz, evaluator|
       create_list(:question, 3, quiz: quiz)
     end
   end
  end
end
