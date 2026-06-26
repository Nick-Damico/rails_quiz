FactoryBot.define do
  factory :category do
    name { Faker::Educator.unique.subject }
    slug { name.parameterize }
  end
end
