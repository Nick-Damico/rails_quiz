require "rails_helper"

RSpec.describe "StudyPlans", type: :request do
  let!(:author) { create(:user) }
  let!(:study_plan) { create(:study_plan, user: author) }

  before do
    sign_in author
  end

  # GET :index
  describe "GET /study_plans" do
    it "responds with HTTP status ok(200)" do
      get user_study_plans_path(user_id: author.id)
      expect(response).to have_http_status(:ok)
    end
  end

  # GET :new
  describe "GET /users/:user_id/study_plans/new" do
    it "responds with HTTP status ok(200)" do
      get user_study_plans_path(user_id: author.id)
      expect(response).to have_http_status(:ok)
    end
  end

  # GET :create
  describe "POST /create" do
    context 'valid params' do
      let(:valid_params) { { study_plan: { name: 'CS 101 Study Plan', description: 'Master the fundamentals of Computer Science.' } } }

      context "with valid params" do
        it "responds with HTTP status redirect(302)" do
          post user_study_plans_path(author), params: valid_params

          expect(response).to have_http_status(:redirect)
        end

        it "creates an authored Study Plan" do
          expect {
            post user_study_plans_path(author), params: valid_params
          }.to change(StudyPlan, :count).by(1)
        end
        it "renders a successful response message" do
          post user_study_plans_path(author), params: valid_params

          expect(flash[:notice]).to eq("Study plan was successfully created.")
        end
      end

      xcontext "with invalid params" do
        let(:invalid_params) { { study_plan: { name: '', description: 'Master the fundamentals of Computer Science.' } } }

        it "responds with HTTP status redirect(302)" do
          post user_study_plans_path(author), params: invalid_params

          expect(response).to have_http_status(:redirect)
        end

        it "does not create an authored quiz" do
          expect {
            post user_study_plans_path(author), params: invalid_params
          }.to change(StudyPlan, :count).by(1)
        end

        it "renders a successful response message" do
          post user_study_plans_path(author), params: valid_params
          expect(flash[:notice]).to eq("Study plan was successfully created.")
        end
      end
    end
  end

  # GET :show
  xdescribe "GET /users/:user_id/study_plans/:id" do
    it "responds with HTTP status ok(200)" do
      get user_study_plan_path(author, study_plan)
      expect(response).to have_http_status(:ok)
    end
  end
end
