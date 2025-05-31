class StudyPlanDeck < ApplicationRecord
  belongs_to :study_plan
  belongs_to :deck

  validates :deck_id, uniqueness: { scope: :study_plan_id, message: "Deck already added to this study plan" }
end
