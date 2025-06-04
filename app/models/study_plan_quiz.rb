class StudyPlanQuiz < ApplicationRecord
  belongs_to :study_plan
  belongs_to :quiz

  validates :quiz_id, uniqueness: {
    scope: :study_plan_id, message: "Quiz already added to this study plan" }
end
