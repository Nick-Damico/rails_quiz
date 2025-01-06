require "rails_helper"

RSpec.describe Author::QuizzesController, type: :request do
  let!(:author) { create(:user) }

  before { sign_in author }

  describe "GET /new" do
    it "responds with HTTP status ok(200)" do
      get new_author_quiz_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /show" do
    it "responds with HTTP status ok(200)" do
      quiz = create(:quiz, author:)
      get author_quiz_path(quiz)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context 'valid params' do
      let(:valid_params) { { quiz: { title: 'Best Quiz', description: 'My first Quiz!' } } }

      it "responds with HTTP status redirect(302)" do
        post author_quizzes_path, params: valid_params

        expect(response).to have_http_status(:redirect)
      end

      it "creates an authored quiz" do
        expect {
          post author_quizzes_path, params: valid_params
        }.to change(Quiz, :count).by(1)
      end
    end

    context 'invalid params' do
      # Missing required :title field
      let(:invalid_params) { { quiz: { title: '', description: 'My first Quiz!' } } }

      it "responds with HTTP status unprocessable entity(400)" do
        post author_quizzes_path, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create an authored quiz' do
        expect {
          post quizzes_path(author_id: author), params: invalid_params
        }.to change(Quiz, :count).by(0)
      end
    end
  end

  describe "GET /edit" do
    let!(:quiz) { create(:quiz, author: author) }

    it "responds with HTTP status ok(200)" do
      get edit_author_quiz_path(quiz)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT /update" do
    let!(:quiz) { create(:quiz, author: author) }

    context "Valid params" do
      let(:valid_params) { quiz.attributes.merge(title: 'Best Quiz Ever') }

      it "responds with HTTP status redirect(302)" do
        put quiz_path(quiz, author_id: author), params: { quiz: valid_params }

        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to eq(I18n.t("flash.quizzes.update.success"))
      end

      it "redirects to :index author_quizzes_url" do
        put quiz_path(quiz, author_id: author), params: { quiz: valid_params }

        expect(response).to redirect_to quizzes_url(author_id: author)
      end
    end

    context "Invalid params" do
      let(:invalid_params) { quiz.attributes.merge(title: '') }

      it "responds with HTTP status unprocessable_entity(422)" do
        put quiz_path(quiz, author_id: author), params: { quiz: invalid_params }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders with an error message" do
        put quiz_path(quiz, author_id: author), params: { quiz: invalid_params }

        expect(flash[:alert]).to eq(I18n.t("flash.quizzes.update.error"))
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:quiz) { create(:quiz, author: author) }

    context "Valid params" do
      it "responds with HTTP status redirect(302)" do
        delete quiz_path(quiz, author_id: author)

        expect(response).to have_http_status(:redirect)
      end

      it "renders with a success message" do
        delete quiz_path(quiz, author_id: author)

        expect(flash[:notice]).to eq(I18n.t("flash.quizzes.destroy.success"))
      end

      it "destroys the quiz record" do
        expect {
          delete quiz_path(quiz, author_id: author)
        }.to change(Quiz, :count).by(-1)
      end
    end

    context "Invalid params" do
      before do
        allow(quiz).to receive(:destroy).and_return(false)
        allow(Quiz).to receive(:find).and_return(quiz)
      end

      it "responds with HTTP status redirect(302)" do
        delete quiz_path(quiz, author_id: author)

        expect(response).to have_http_status(:redirect)
      end

      it "renders with an error message" do
        delete quiz_path(quiz, author_id: author)

        expect(flash[:alert]).to eq(I18n.t("flash.quizzes.destroy.error"))
      end

      it "does not destroy the quiz record" do
        expect {
          delete quiz_path(quiz, author_id: author)
        }.to change(Quiz, :count).by(0)
      end
    end
  end
end
