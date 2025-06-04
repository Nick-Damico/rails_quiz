require 'rails_helper'

RSpec.describe StudyPlanQuiz, type: :model do
  let!(:study_plan_quiz) { create(:study_plan_quiz) }

  it { should belong_to(:study_plan) }
  it { should belong_to(:quiz) }

  it { should validate_uniqueness_of(:quiz_id)
              .scoped_to(:study_plan_id)
              .with_message("Quiz already added to this study plan") }
end
