require 'rails_helper'

RSpec.describe "Questions", type: :request do
  let!(:author) { create(:user) }
  let!(:quiz) { create(:quiz, author:) }

  before { sign_in author }

  describe "GET /new" do
    it "responds with HTTP status ok(200)" do
      get new_quiz_question_path(quiz)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "with valid params" do
      let(:valid_params) { { question: { content: Faker::Lorem.sentence, quiz_id: quiz.id } } }

      it "responds with HTTP status redirect(302)" do
        post quiz_questions_path(quiz), params: valid_params

        expect(response).to have_http_status(:redirect)
      end

      it "creates a question record" do
        expect {
          post quiz_questions_path(quiz), params: valid_params
        }.to change(Question, :count).by(1)

        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { question: { content: "", quiz_id: quiz.id } } }

      it "responds with HTTP status unprocessable entity(422)" do
        post quiz_questions_path(quiz), params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "creates a question record" do
        expect {
          post quiz_questions_path(quiz), params: invalid_params
        }.to change(Question, :count).by(0)
      end
    end
  end
end
