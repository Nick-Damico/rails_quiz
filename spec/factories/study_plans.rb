FactoryBot.define do
  factory :study_plan do
    user { create(:user) }
    name { "Study Plan #{Faker::Number.unique.number(digits: 3)}" }
    description { Faker::Lorem.sentence(word_count: 10) }
  end
end
