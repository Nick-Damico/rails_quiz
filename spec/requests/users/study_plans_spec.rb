require "rails_helper"

RSpec.describe "StudyPlans", type: :request do
  let!(:user) { create(:user) }
  let!(:study_plan) { create(:study_plan, user: user) }

  before do
    sign_in user
  end

  # GET :index
  describe "GET /study_plans" do
    it "returns a list of study plans" do
      get user_study_plans_path(user_id: user.id)
      expect(response).to have_http_status(:ok)
    end
  end

  # GET :new
  describe "GET /users/:user_id/study_plans/new" do
    it "returns a list of study plans" do
      get user_study_plans_path(user_id: user.id)
      expect(response).to have_http_status(:ok)
    end
  end
end
