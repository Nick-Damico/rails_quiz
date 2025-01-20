require 'rails_helper'

RSpec.describe AnswerSheet, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:quiz) }
  it { should have_many(:answer_sheet_questions) }

  describe "#next_incomplete_question" do
    it "returns the first incomplete answer_sheet_question" do
      answer_sheet = create(:answer_sheet)
      answer_sheet.prepare

      answer_sheet_question = answer_sheet.answer_sheet_questions.first
      choice = answer_sheet_question.question.choices.first
      answer_sheet_question.update(answer: choice)

      expect(answer_sheet.next_incomplete_question).to eq(answer_sheet.answer_sheet_questions.second)
    end
  end

  describe "#completed?" do
    it "returns true if all answer_sheet_questions are answered" do
      answer_sheet = create(:answer_sheet, :with_completed_quiz)

      expect(answer_sheet.completed?).to eq(true)
    end
  end
end
