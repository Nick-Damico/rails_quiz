require "rails_helper"

RSpec.describe "Question::Choices", type: :request do
  let!(:author) { create(:user) }
  let!(:question) { create(:question) }

  before { sign_in author }

  describe "GET /new" do
    it "responds with HTTP status ok(200)" do
      get new_question_choice_path(question)

      expect(response).to have_http_status(:ok)
    end
  end

end
