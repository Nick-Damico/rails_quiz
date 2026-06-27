FactoryBot.define do
  factory :quiz do
    title { "#{Faker::Lorem.sentence(word_count: 3)} Quiz" }
    description { Faker::Lorem.paragraph }
    author { create(:user) }
    category { create(:category) }

    transient do
      questions_count { 2 }
    end

    after(:create) do |quiz, evaluator|
      create_list(:question, evaluator.questions_count, quiz:)
    end

    trait :with_questions do
      transient do
        questions_count { 1 }
      end
    end
  end
end
