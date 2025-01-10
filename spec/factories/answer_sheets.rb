FactoryBot.define do
  factory :answer_sheet do
    quiz { create(:quiz) }
    user { create(:user) }
    grade { 90.00 }
  end
end
