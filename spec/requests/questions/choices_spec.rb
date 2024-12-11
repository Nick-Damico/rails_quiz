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

  describe "GET /edit" do
    let!(:choice) { create(:choice, question:) }

    it "responds with HTTP status ok(200)" do
      get edit_question_choice_path(question, choice)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT /update" do
    context "with valid params" do
      let!(:choice) { create(:choice, question:) }
      let(:valid_params) { { question_choice: { content: Faker::Lorem.sentence, question_id: question.id } } }

      it "responds with HTTP status redirect(302)" do
        put question_choice_path(question, choice), params: valid_params

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(quiz_question_url(question.quiz_id, question))
      end

      it "updates the Choice record" do
        expect {
          put question_choice_path(question, choice), params: valid_params
        }.to change(Question::Choice, :count).by(0)

        new_choice_content = valid_params.dig(:question_choice, :content)
        expect(choice.reload.content).to eq(new_choice_content)
      end

      it "displays a flash success message" do
        put question_choice_path(question, choice), params: valid_params

        expect(flash[:notice]).to eq(I18n.t("flash.choices.update.success"))
      end
    end

    context "with invalid params" do
      let!(:choice) { create(:choice, question:) }
      let(:invalid_params) { { question_choice: { content: '', question_id: question.id } } }

      it "responds with HTTP status unprocessable entity(422)" do
        put question_choice_path(question, choice), params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not update the Choice record" do
        put question_choice_path(question, choice), params: invalid_params

        new_choice_content = invalid_params.dig(:question_choice, :content)
        expect(choice.reload.content).to_not eq(new_choice_content)
      end

      it "displays a flash error message" do
        put question_choice_path(question, choice), params: invalid_params

        expect(flash[:alert]).to eq(I18n.t("flash.choices.update.error"))
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:choice) { create(:choice, question:) }

    context "valid request" do
      it "responds with HTTP status :no_content(204)" do
        delete question_choice_path(question, choice)

        expect(response).to have_http_status(:no_content)
      end

      it "deletes the Choice record" do
        expect {
          delete question_choice_path(question, choice)
        }.to change(Question::Choice, :count).by(-1)
      end

      it "displays a flash success message" do
        delete question_choice_path(question, choice)

        expect(flash[:notice]).to eq(I18n.t("flash.choices.destroy.success"))
      end
    end

    context "invalid request" do
      before(:each) do
        allow_any_instance_of(Question::Choice).to receive(:destroy).and_return(false)
      end

      it "responds with HTTP status :bad_request(404)" do
        delete question_choice_path(question, choice)

        expect(response).to have_http_status(:bad_request)
      end

      it "does not delete the Choice record" do
        expect {
          delete question_choice_path(question, choice)
        }.to change(Question::Choice, :count).by(0)
      end

      it "displays a flash error message" do
        delete question_choice_path(question, choice)

        expect(flash[:alert]).to eq(I18n.t("flash.choices.destroy.error"))
      end
    end
  end
end
