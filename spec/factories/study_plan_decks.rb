FactoryBot.define do
  factory :study_plan_deck do
    study_plan { create(:study_plan) }
    deck { create(:deck) }
  end
end
