FactoryBot.define do
  factory :question do
    quiz { create(:quiz) }
    content { Faker::Lorem.sentence(word_count: 5) }

    after(:build) do |question, _evaluator|
      question.choices << build(:choice)
      question.choices << build(:choice, correct: true)
    end
  end
end
