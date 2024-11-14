FactoryBot.define do
  factory :answer do
    quiz { create(:quiz) }
    content { Faker::Lorem.sentence(word_count: 6) }
  end
end
