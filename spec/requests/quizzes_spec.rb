require "rails_helper"

RSpec.describe "Quizzes", type: :request do
  let!(:author) { create(:user) }

  before { sign_in author }

  describe "GET /new", type: :request do
    it "responds with HTTP status success(200)" do
      get new_author_quiz_path(author)

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create", type: :request do
    context 'valid params' do
      it "responds with HTTP status success(302)" do
        post author_quizzes_path(author), params: { quiz: { name: 'Best Quiz', description: 'My first Quiz!' } }

        expect(response).to have_http_status(:redirect)
      end

      it "creates an authored quiz" do
        expect {
          post author_quizzes_path(author), params: { quiz: { name: 'Best Quiz', description: 'My first Quiz!' } }
        }.to change(Quiz, :count).by(1)
      end
    end
  end
end
