require 'rails_helper'

RSpec.describe AnswerSheet, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:quiz) }
  it { should have_many(:answer_sheet_questions) }

  describe ".in_progress_answer_sheet_for(quiz:, user:)" do
    it "returns an 'in-progress' answer_sheet for a given quiz and user" do
      answer_sheet = create(:answer_sheet)

      answer_sheet.prepare
      quiz = answer_sheet.quiz
      user = answer_sheet.user

      expect(AnswerSheet.in_progress_answer_sheet_for(user:, quiz:)).to eq(answer_sheet)
    end
  end

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

    it "returns false if not all answer_sheet_questions are answered" do
      answer_sheet = create(:answer_sheet)
      answer_sheet.prepare
      answer_sheet_question = answer_sheet.answer_sheet_questions.first
      answer_sheet_question.update(answer: answer_sheet_question.question.choices.sample)

      expect(answer_sheet.completed?).to eq(false)
    end

    it "returns false with empty answer_sheet_questions" do
      answer_sheet = create(:answer_sheet)

      expect(answer_sheet.answer_sheet_questions).to be_empty
      expect(answer_sheet.completed?).to eq(false)
    end
  end

  describe "#graded?" do
    context "not graded" do
      it "returns false" do
        answer_sheet = create(:answer_sheet, :with_completed_quiz)

        expect(answer_sheet.graded?).to eq(false)
      end
    end

    context "graded" do
      it "returns true" do
        answer_sheet = create(:answer_sheet, :with_grade)

        expect(answer_sheet.graded?).to eq(true)
      end
    end
  end
end
