FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Name.name }
    password { Faker::Internet.password(min_length: 8, max_length: 8, mix_case: true, special_characters: true) }

    after(:build) do |user, evaluator|
      user.password_confirmation = user.password
    end
  end
end
