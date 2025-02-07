require "rails_helper"

RSpec.describe AnswerSheetQuestionsController, type: :request do
  let!(:user) { create(:user) }
  let!(:answer_sheet) { create(:answer_sheet, user:) }

  before do
    sign_in user

    answer_sheet.prepare
  end

  describe "GET /show" do
    it "responds with HTTP status 200(ok)" do
      answer_sheet_question = answer_sheet.answer_sheet_questions.first

      get answer_sheet_question_path(answer_sheet_question)

      expect(response).to have_http_status(200)
    end
  end

  describe "PUT /update" do
    let(:answer_sheet_question) { answer_sheet.answer_sheet_questions.first }

    context "with valid params" do
      let!(:valid_params) { {
          answer_sheet_question: { answer_id: answer_sheet_question.question.choices.first.id }
        }
      }

      it "responds with HTTP status redirect(302)" do
        put answer_sheet_question_path(answer_sheet_question), params: valid_params

        expect(response).to have_http_status(:redirect)
      end

      it "responds with redirect to the next incomplete question" do
        answer_sheet = answer_sheet_question.answer_sheet

        put answer_sheet_question_path(answer_sheet_question), params: valid_params

        expect(response).to redirect_to(answer_sheet.next_incomplete_question)
      end

      it "renders flash notice with success message" do
        put answer_sheet_question_path(answer_sheet_question), params: valid_params

        expect(flash[:notice]).to eq(I18n.t("flash.answer_sheet_questions.update.success"))
      end

      context "completed answer_sheet" do
        it "redirects to the answer_sheet once completed" do
          answer_sheet.answer_sheet_questions[0...-1].each do |answer_sheet_question|
            answer = answer_sheet_question.question.choices.first
            answer_sheet_question.update(answer:)
          end
          last_answer_sheet_question = answer_sheet.answer_sheet_questions.last

          put answer_sheet_question_path(last_answer_sheet_question), params: valid_params

          expect(response).to redirect_to(answer_sheet)
        end
      end
    end

    context "with invalid params" do
      # Missing required :answer_id
      let!(:invalid_params) { {
          answer_sheet_question: { answer_id: '' }
        }
      }

      it "responds with HTTP status unprocessable_entity(422)" do
        put answer_sheet_question_path(answer_sheet_question), params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders flash alert with error message" do
        put answer_sheet_question_path(answer_sheet_question), params: invalid_params

        expect(flash[:alert]).to eq(I18n.t("flash.answer_sheet_questions.update.error"))
      end
    end
  end
end
