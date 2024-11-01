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
      let(:valid_params) { { quiz: { title: 'Best Quiz', description: 'My first Quiz!' } } }

      it "responds with HTTP status redirect(302)" do
        post author_quizzes_path(author), params: valid_params

        expect(response).to have_http_status(:redirect)
      end

      it "creates an authored quiz" do
        expect {
          post author_quizzes_path(author), params: valid_params
        }.to change(Quiz, :count).by(1)
      end
    end

    context 'invalid params' do
      # Missing required :title field
      let(:invalid_params) { { quiz: { title: '', description: 'My first Quiz!' } } }

      it "responds with HTTP status unprocessable entity(400)" do
        post author_quizzes_path(author), params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'creates an authored quiz' do
        expect {
          post author_quizzes_path(author), params: invalid_params
        }.to change(Quiz, :count).by(0)
      end
    end
  end

  describe "GET /edit", type: :request do
    let!(:quiz) { create(:quiz, author: author) }

    it "responds with HTTP status ok(200)" do
      get edit_author_quiz_path(author, quiz)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT /update", type: :request do
    let!(:quiz) { create(:quiz, author: author) }

    context "Valid params" do
      let(:valid_params) { quiz.attributes.merge(title: 'Best Quiz Ever') }

      it "responds with HTTP status redirect(302)" do
        put author_quiz_path(author, quiz), params: { quiz: valid_params }

        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to eq(I18n.t("flash.quizzes.update.success"))
      end

      it "redirects to :index author_quizzes_url" do
        put author_quiz_path(author, quiz), params: { quiz: valid_params }

        expect(response).to redirect_to author_quizzes_url(author)
      end
    end

    context "Invalid params" do
      let(:invalid_params) { quiz.attributes.merge(title: '') }

      it "responds with HTTP status unprocessable_entity(422)" do
        put author_quiz_path(author, quiz), params: { quiz: invalid_params }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders with an error message" do
        put author_quiz_path(author, quiz), params: { quiz: invalid_params }

        expect(flash[:alert]).to eq(I18n.t("flash.quizzes.update.error"))
      end
    end
  end

  describe "DELETE /destroy", type: :request do
    let!(:quiz) { create(:quiz, author: author) }

    context "Valid params" do
      it "responds with HTTP status redirect(302)" do
        delete author_quiz_path(author, quiz)

        expect(response).to have_http_status(:redirect)
      end

      it "renders with a success message" do
        delete author_quiz_path(author, quiz)

        expect(flash[:notice]).to eq(I18n.t("flash.quizzes.delete.success"))
      end

      it "destroys the quiz record" do
        expect {
          delete author_quiz_path(author, quiz)
        }.to change(Quiz, :count).by(-1)
      end
    end

    context "Invalid params" do
      before do
        allow(quiz).to receive(:destroy).and_return(false)
        allow(Quiz).to receive(:find).and_return(quiz)
      end

      it "responds with HTTP status redirect(302)" do
        delete author_quiz_path(author, quiz)

        expect(response).to have_http_status(:redirect)
      end

      it "renders with an error message" do
        delete author_quiz_path(author, quiz)

        expect(flash[:alert]).to eq(I18n.t("flash.quizzes.delete.error"))
      end

      it "does not destroy the quiz record" do
        expect {
          delete author_quiz_path(author, quiz)
        }.to change(Quiz, :count).by(0)
      end
    end
  end
end
