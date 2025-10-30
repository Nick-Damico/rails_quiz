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

        expect(study_plan.quizzes).to include(quiz)
      end

      it "sets a flash success notice message" do
        post study_plan_quizzes_path(study_plan), params: { quiz: { quiz_id: quiz.id } }

        expect(flash[:notice]).to eq("Quiz was successfully added to your study plan.")
      end
    end

    context "with invalid params" do
      let(:bad_id) { 0 }
      it "responds with HTTP status unprocessable_entity(402)" do
        post study_plan_quizzes_path(study_plan), params: { quiz: { quiz_id: bad_id } }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "sets a flash error notice message" do
        post study_plan_quizzes_path(study_plan), params: { quiz: { quiz_id: bad_id } }

        expect(flash[:alert]).to eq("There was an issue adding this quiz to your study plan. Refresh page and try again.")
      end
    end
  end

  # DELETE /study_plans/:study_plan_id/quizzes/:id
  describe "DELETE /destroy" do
    context "with valid params" do
      it "responds with HTTP status 302(:found)" do
        delete study_plan_quiz_path(study_plan, quiz)

        expect(response).to have_http_status(:found)
      end

      it "sets a flash success notice message" do
        delete study_plan_quiz_path(study_plan, quiz)

        expect(flash[:notice]).to eq("Quiz: #{quiz.title} was successfully removed from your study plan.")
      end

      it "removes the quiz from study plan without deleting the record" do
        study_plan.quizzes << quiz

        expect {
          delete study_plan_quiz_path(study_plan, quiz)
        }.to change(Quiz, :count).by(0)

        expect(study_plan.reload.quizzes).not_to include(quiz)
      end
    end
  end
end
