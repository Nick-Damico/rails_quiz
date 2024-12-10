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

  describe "POST /create" do
    context "with valid params" do
      let(:valid_params) { { question_choice: { content: Faker::Lorem.sentence, question_id: question.id } } }

      it "responds with HTTP status redirect(302)" do
        post question_choices_path(question), params: valid_params

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(quiz_question_url(question.quiz_id, question))
      end

      it "creates a Choice record" do
        expect {
          post question_choices_path(question), params: valid_params
        }.to change(Question::Choice, :count).by(1)
      end

      it "displays a flash success message" do
        post question_choices_path(question), params: valid_params

        expect(flash[:notice]).to eq(I18n.t("flash.choices.create.success"))
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { question_choice: { content: '', question_id: question.id } } }

      it "responds with HTTP status unprocessable entity(422)" do
        post question_choices_path(question), params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not create a Choice record" do
        expect {
          post question_choices_path(question), params: invalid_params
        }.to change(Question::Choice, :count).by(0)
      end

      it "displays a flash error message" do
        post question_choices_path(question), params: invalid_params

        expect(flash[:alert]).to eq(I18n.t("flash.choices.create.error"))
      end
    end
  end
end
