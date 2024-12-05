FactoryBot.define do
  factory :question do
    quiz { create(:quiz) }
    content { Faker::Lorem.sentence(word_count: 5) }

    after(:create) do |question, evaluator|
      create_list(:choice, 1,  question:)
    end
  end
end
