require "rails_helper"

RSpec.describe QuizzesController, type: :request do
  let!(:student_user) { create(:user) }

  before { sign_in student_user }

  describe "GET /index" do
    it "responds with HTTP status ok(200)" do
      get quizzes_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /show" do
    it "responds with HTTP status ok(200)" do
      quiz = create(:quiz)

      get quiz_path(quiz)

      expect(response).to have_http_status(:ok)
    end
  end
end
