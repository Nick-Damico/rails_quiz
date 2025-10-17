require "rails_helper"

RSpec.describe "StudyPlansController", type: :request do
  let!(:author) { create(:user) }

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
    let!(:study_plan) { create(:study_plan, user: author) }
    before { get user_study_plan_path(author, study_plan) }
    it "responds with HTTP status ok(200)" do
      expect(response).to have_http_status(:ok)
    end

    it "renders study plan data" do
      expect(response.body).to include(study_plan.name)
      expect(response.body).to include(study_plan.description)
    end
  end

  describe "GET /edit" do
    let!(:study_plan) { create(:study_plan, user: author) }
    it "responds with HTTP status ok(200)" do
      get edit_user_study_plan_path(author, study_plan)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /update" do
    let!(:study_plan) { create(:study_plan, user: author) }

    context "valid params" do
      let(:valid_params) { { study_plan: { name: "Updated Study Plan", description: "Updated description." } } }

      before { patch user_study_plan_path(author, study_plan), params: valid_params }

      it "responds with HTTP status redirect(302)" do
        expect(response).to have_http_status(:redirect)
      end

      it "updates the study plan" do
        expect(study_plan.reload.name).to eq("Updated Study Plan")
        expect(study_plan.reload.description).to eq("Updated description.")
      end

      it "renders a successful response message" do
        expect(flash[:notice]).to eq("Study plan was successfully updated.")
      end
    end

    context "invalid params" do
      let(:invalid_params) { { study_plan: { name: '', description: "Updated description." } } }

      before { patch user_study_plan_path(author, study_plan), params: invalid_params }

      it "responds with HTTP status unprocessable_entity(402)" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not update the study plan" do
        expect(study_plan.reload.description).to_not eq("Updated description.")
      end

      it "renders an error response message" do
        expect(flash[:alert]).to eq("There was an error updating this study plan.")
      end
    end
  end
  describe "DELETE /destroy" do
    let!(:study_plan) { create(:study_plan, user: author) }

    context "Valid params" do
      it "responds with HTTP status redirect(302)" do
        delete user_study_plan_path(author, study_plan)

        expect(response).to have_http_status(:redirect)
      end

      it "renders with a success message" do
        delete user_study_plan_path(author, study_plan)

        expect(flash[:notice]).to eq("Study plan was successfully deleted.")
      end

      it "destroys the study plan record" do
        expect {
          delete user_study_plan_path(author, study_plan)
        }.to change(StudyPlan, :count).by(-1)
      end
    end

    context "Invalid params" do
      it "prevents a user from deleting another user's study plan" do
        another_user = create(:user)
        sign_out author
        sign_in another_user

        expect {
          delete user_study_plan_path(author, study_plan)
        }.to change(StudyPlan, :count).by(0)

        expect(flash[:error]).to eq("You cannot perform this action.")
      end

      it "responds with HTTP status redirect(302)" do
        delete user_study_plan_path(author, study_plan)

        expect(response).to have_http_status(:redirect)
      end

      it "renders with an error message" do
        allow_any_instance_of(StudyPlan).to receive(:destroy).and_return(false)

        delete user_study_plan_path(author, study_plan)

        expect(flash[:alert]).to eq("There was an error deleting the study plan.")
      end

      it "does not destroy associated quiz records" do
        allow_any_instance_of(StudyPlan).to receive(:destroy).and_return(false)

        expect {
          delete user_study_plan_path(author, study_plan)
        }.to change(Quiz, :count).by(0)
      end

      it "does not destroy associated flashcard deck records" do
        allow_any_instance_of(StudyPlan).to receive(:destroy).and_return(false)

        expect {
          delete user_study_plan_path(author, study_plan)
        }.to change(Deck, :count).by(0)
      end
    end
  end
end
