require "rails_helper"

RSpec.describe AnswerSheetsController, type: :request do
  let!(:user) { create(:user) }
  let!(:quiz) { create(:quiz) }

  before { sign_in user }

  describe "POST /create" do
    let!(:valid_params) { { answer_sheet: { user_id: user.id, quiz_id: quiz.id } } }

    it "responds with HTTP status redirect(302)" do
      post answer_sheets_path, params: valid_params

      expect(response).to have_http_status(:redirect)
    end

    context "with valid params" do
      it "creates a new answer sheet" do
        expect {
          post answer_sheets_path, params: valid_params
        }.to change(AnswerSheet, :count).by(1)
      end
    end
  end
end
