require "rails_helper"

RSpec.describe "StudyPlans::QuizzesController", type: :request do
  let!(:user) { create(:user) }
  let!(:study_plan) { create(:study_plan, user:) }
  let!(:quiz) { create(:quiz) }

  before { sign_in user }

  # POST /study_plans/:study_plan_id/quizzes
  describe "POST /create" do
    context "with valid params" do
      it "responds with HTTP status 302(:found)" do
        post study_plan_quizzes_path(study_plan), params: { quiz: { quiz_id: quiz.id } }

        expect(response).to have_http_status(:found)
      end

      it "adds the quiz to the study plan" do
        expect {
          post study_plan_quizzes_path(study_plan), params: { quiz: { quiz_id: quiz.id } }
        }.to change { study_plan.quizzes.count }.by(1)
      end
    end
  end

  # DELETE /study_plans/:study_plan_id/quizzes/:id
  describe "DELETE /destroy" do; end
end
