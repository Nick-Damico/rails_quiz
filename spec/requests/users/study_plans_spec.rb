require "rails_helper"

RSpec.describe "StudyPlans", type: :request do
  let!(:author) { create(:user) }
  let!(:study_plan) { create(:study_plan, user: author) }

  before do
    sign_in author
  end

  # GET :index
  describe "GET /index" do
    it "responds with HTTP status ok(200)" do
      get user_study_plans_path(user_id: author.id)
      expect(response).to have_http_status(:ok)
    end
  end

  # GET :new
  describe "GET /new" do
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

        it "creates an Study Plan" do
          expect {
            post user_study_plans_path(author), params: valid_params
          }.to change(StudyPlan, :count).by(1)
        end
        it "renders a successful response message" do
          post user_study_plans_path(author), params: valid_params

          expect(flash[:notice]).to eq("Study plan was successfully created.")
        end
      end

      context "with invalid params" do
        let!(:invalid_params) { { study_plan: { name: '', description: 'Master the fundamentals of Computer Science.' } } }

        it "responds with HTTP status unprocessable entity(400)" do
          post user_study_plans_path(author), params: invalid_params

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "does not create an study plan" do
          expect {
            post user_study_plans_path(author), params: invalid_params
          }.to change(StudyPlan, :count).by(0)
        end

        it "renders a error response message" do
          post user_study_plans_path(author), params: invalid_params
          expect(response.body).to include("There was an error creating this study plan.")
        end
      end
    end
  end

  # GET :show
  describe "GET /show" do
    before { get user_study_plan_path(author, study_plan) }
    it "responds with HTTP status ok(200)" do
      expect(response).to have_http_status(:ok)
    end

    it "renders study plan data" do
      expect(response.body).to include(study_plan.name)
      expect(response.body).to include(study_plan.description)
    end
  end
end
