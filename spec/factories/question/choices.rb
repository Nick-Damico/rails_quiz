FactoryBot.define do
  factory :choice, class: 'Question::Choice' do
    content { Faker::Lorem.sentence }
    correct { false }
    question { create(:question) }
  end
end
