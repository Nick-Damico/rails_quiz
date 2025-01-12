require 'rails_helper'

RSpec.describe AnswerSheetQuestion, type: :model do
  it { should belong_to(:question) }
  it { should belong_to(:answer_sheet) }
  it { should belong_to(:answer).optional(true) }

  describe "#prepare" do
    it "initializes one answer_sheet_question for each question in the quiz" do
      quiz = create(:quiz, questions_count: 3)
      answer_sheet = create(:answer_sheet, quiz:)

      answer_sheet.prepare

      expect(answer_sheet.answer_sheet_questions.count).to eq(3)
    end
  end
end
