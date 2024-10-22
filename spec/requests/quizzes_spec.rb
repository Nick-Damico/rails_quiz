require "rails_helper"

RSpec.describe "Quizzes", type: :request do
  let!(:author) { create(:user) }

  before { sign_in author }

  describe "GET /new", type: :request do
    it "responds with HTTP status ok(200)" do
      get new_author_quiz_path(author)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create", type: :request do
    context 'valid params' do
      let(:valid_params) { { quiz: { name: 'Best Quiz', description: 'My first Quiz!' } } }

      it "responds with HTTP status success(302)" do
        post author_quizzes_path(author), params: valid_params

        expect(response).to have_http_status(:redirect)
      end

      it "creates an authored quiz" do
        expect {
          post author_quizzes_path(author), params: valid_params
        }.to change(Quiz, :count).by(1)
      end
    end
  end

  describe "POST /create", type: :request do
    context 'invalid params' do
      # Missing required :name field
      let(:invalid_params) { { quiz: { name: '', description: 'My first Quiz!' } } }

      it "responds with HTTP status unprocessable entity(400)" do
        post author_quizzes_path(author), params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "creates an authored quiz" do
        expect {
          post author_quizzes_path(author), params: invalid_params
        }.to change(Quiz, :count).by(0)
      end
    end
  end
end
