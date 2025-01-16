require "rails_helper"

RSpec.describe AnswerSheetQuestionsController, type: :request do
  let!(:user) { create(:user) }
  let!(:answer_sheet) { create(:answer_sheet) }

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
    context "with valid params" do
      let(:answer_sheet_question) { answer_sheet.answer_sheet_questions.first }
      let!(:valid_params) { {
          answer_sheet_question: {
            question_id: answer_sheet_question.question_id,
            answer_sheet_id: answer_sheet_question.answer_sheet_id,
            answer_id: answer_sheet_question.question.choices.first.id
          }
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


  #   context "with invalid params" do
  #     # Missing required :quiz_id
  #     let!(:invalid_params) { { answer_sheet: { user_id: user.id, quiz_id: nil } } }

  #     it "responds with HTTP status unprocessable_entity(422)" do
  #       post answer_sheets_path, params: invalid_params

  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end

  #     it "does not create an answer_sheet" do
  #       expect {
  #         post answer_sheets_path, params: invalid_params
  #       }.to change(AnswerSheet, :count).by(0)
  #     end
  #   end
  # end

  # describe "DELETE /destroy" do
  #   let!(:answer_sheet) { create(:answer_sheet, user: user, quiz: quiz) }

  #   context "success" do
  #     it "destroys the answer_sheet record" do
  #       expect {
  #         delete answer_sheet_path(answer_sheet)
  #       }.to change(AnswerSheet, :count).by(-1)
  #     end

  #     it "responds with HTTP status redirec(302)" do
  #       delete answer_sheet_path(answer_sheet)

  #       expect(response).to have_http_status(:redirect)
  #       expect(response).to redirect_to(answer_sheet.quiz)
  #     end
  #   end
  # end
  end
end
