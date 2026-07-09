# spec/requests/study_plan_quizzes_spec.rb
require "rails_helper"

RSpec.describe "StudyPlanQuizzes", type: :request do
  let(:user) { create(:user) }
  let(:study_plan) { create(:study_plan, user: user) }
  let(:quiz) { create(:quiz) }

  before do
    sign_in user
  end

  describe "POST /study_plan_quizzes" do
    subject(:create_study_plan_quiz) do
      post study_plan_quizzes_path,
           params: { study_plan_quiz: { study_plan_id: study_plan.id, quiz_id: quiz.id } }
    end

    context "when the quiz is successfully added to the study plan" do
      it "creates a study plan quiz association" do
        expect { create_study_plan_quiz }
          .to change(StudyPlanQuiz, :count).by(1)
      end

      it "redirects to the study plan show page" do
        create_study_plan_quiz

        # expect(response).to render_template("users/study_plans/show")
        expect(response).to redirect_to(user_study_plan_path(user, study_plan))
      end

      it "sets a success flash message" do
        create_study_plan_quiz

        expect(flash[:notice]).to eq("Quiz was successfully added to your study plan.")
      end
    end

    context "when the quiz is already in the study plan" do
      before do
        create(:study_plan_quiz, study_plan: study_plan, quiz: quiz)
      end
      it "does not create another study plan quiz association" do
        expect { create_study_plan_quiz }
          .not_to change(StudyPlanQuiz, :count)
      end

      it "redirects the quiz show page" do
        create_study_plan_quiz

        expect(response).to redirect_to quiz_path(quiz)
      end

      it "sets an error flash message" do
        create_study_plan_quiz

        expect(flash[:alert]).to eq(
          "Quiz already added to your study plan. Please select a different quiz."
        )
      end
    end
  end
end
