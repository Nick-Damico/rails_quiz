require "rails_helper"

RSpec.describe "StudyPlans::QuizzesController", type: :request do
  let!(:study_plan) { create(:study_plan) }

  # POST /study_plans/:study_plan_id/quizzes
  describe "POST /create" do; end

  # DELETE /study_plans/:study_plan_id/quizzes/:id
  describe "DELETE /destroy" do; end
end
