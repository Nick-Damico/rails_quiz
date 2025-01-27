require "rails_helper"

RSpec.describe AnswerSheetsController, type: :request do
  let!(:user) { create(:user) }
  let!(:quiz) { create(:quiz) }

  before { sign_in user }

  describe "GET /show" do
    context "with grade" do
      it "responds with HTTP status 200(ok)" do
        answer_sheet = create(:answer_sheet, :with_grade)

        get answer_sheet_path(answer_sheet)

        expect(response).to have_http_status(:ok)
      end
    end

    context "with incomplete answer_sheet" do
      it "responds with redirect" do
        answer_sheet = create(:answer_sheet)
        get answer_sheet_path(answer_sheet)

        expect(response).to redirect_to(quiz_path(answer_sheet.quiz))
        expect(flash[:alert]).to eq(I18n.t("flash.answer_sheets.show.error"))
      end
    end

    context "with completed and none-graded answer_sheet" do
      let!(:completed_answer_sheet) { create(:answer_sheet, :with_completed_quiz) }

      before do
        expect_any_instance_of(AnswerSheet::Grader).to receive(:grade)

        get answer_sheet_path(completed_answer_sheet)
      end

      it "calls AnswerSheet::Grader" do
        expect(response).to have_http_status(:ok)
      end

      it "responds with HTTP status 200(ok)" do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /resume" do
    it "responds with HTTP status 302(redirect)" do
      answer_sheet_question = create(:answer_sheet_question)
      answer_sheet = answer_sheet_question.answer_sheet

      get resume_answer_sheet_path(answer_sheet)

      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET /pause" do
    it "responds with HTTP status 302(redirect)" do
      answer_sheet_question = create(:answer_sheet_question)
      answer_sheet = answer_sheet_question.answer_sheet

      get pause_answer_sheet_path(answer_sheet)

      expect(response).to have_http_status(:redirect)
    end
  end

  describe "POST /create" do
    context "with valid params" do
      let!(:valid_params) { { answer_sheet: { user_id: user.id, quiz_id: quiz.id } } }

      it "responds with HTTP status redirect(302)" do
        post answer_sheets_path, params: valid_params

        expect(response).to have_http_status(:redirect)
      end

      it "creates an answer_sheet" do
        expect {
          post answer_sheets_path, params: valid_params
        }.to change(AnswerSheet, :count).by(1)
      end
    end

    context "with invalid params" do
      # Missing required :quiz_id
      let!(:invalid_params) { { answer_sheet: { user_id: user.id, quiz_id: nil } } }

      it "responds with HTTP status unprocessable_entity(422)" do
        post answer_sheets_path, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not create an answer_sheet" do
        expect {
          post answer_sheets_path, params: invalid_params
        }.to change(AnswerSheet, :count).by(0)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:answer_sheet) { create(:answer_sheet, user: user, quiz: quiz) }

    context "success" do
      it "destroys the answer_sheet record" do
        expect {
          delete answer_sheet_path(answer_sheet)
        }.to change(AnswerSheet, :count).by(-1)
      end

      it "responds with HTTP status redirec(302)" do
        delete answer_sheet_path(answer_sheet)

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(answer_sheet.quiz)
      end

      it "deletes child answer_sheet_questions" do
        answer_sheet.prepare # generate answer_sheet_questions
        child_record_count = answer_sheet.answer_sheet_questions.count
        expect(child_record_count).to satisfy { |n| n > 0 }

        expect {
          delete answer_sheet_path(answer_sheet)
        }.to change(AnswerSheetQuestion, :count).by(-child_record_count)
      end
    end
  end
end
