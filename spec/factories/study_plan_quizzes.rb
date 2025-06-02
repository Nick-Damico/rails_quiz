FactoryBot.define do
  factory :study_plan_quiz do
    study_plan { create(:study_plan) }
    quiz { create(:quiz) }
  end
end
