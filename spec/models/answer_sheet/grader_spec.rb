require "rails_helper"

RSpec.describe AnswerSheet::Grader, type: :model do
  context "with answer_sheet" do
    it "assigns a score of 100.00 when all answers correct" do
      answer_sheet = create(:answer_sheet, :with_perfect_score)

      described_class.new(answer_sheet).grade

      expect(answer_sheet.grade).to eq(100.00)
    end

    it "assigns a score of 0.00 when all answers are incorrect" do
      answer_sheet = create(:answer_sheet, :with_zero_score)

      described_class.new(answer_sheet).grade

      expect(answer_sheet.grade).to eq(0.00)
    end

    it "assigns a score of 50.00 when half of the answers are correct" do
      answer_sheet = create(:answer_sheet, :with_partial_score)

      described_class.new(answer_sheet).grade

      expect(answer_sheet.grade).to eq(50.00)
    end

    it "rounds the grade to two decimal places" do
      quiz = create(:quiz, questions_count: 3)
      answer_sheet = create(:answer_sheet, :with_zero_score, quiz:)
      first_answer_sheet_question = answer_sheet.answer_sheet_questions.first
      first_answer_sheet_question.update(
        answer: first_answer_sheet_question.question.choices.find(&:correct)
      )

      described_class.new(answer_sheet).grade

      expect(answer_sheet.grade).to eq(33.33)
    end
  end

  context "with incomplete answer_sheet" do
    it "raises an ArgumentError" do
      answer_sheet = create(:answer_sheet)
      answer_sheet.prepare

      expect {
        described_class.new(answer_sheet)
      }.to raise_error(ArgumentError, "Answer sheet must be complete")
    end
  end

  context "without answer_sheet" do
    it "raises an ArgumentError if nil" do
      expect {
        described_class.new(nil)
      }.to raise_error(ArgumentError, "Answer sheet cannot be nil or empty")
    end

    it "raises an ArgumentError if not an AnswerSheet" do
      wrong_argument = create(:quiz)

      expect {
        described_class.new(wrong_argument)
      }.to raise_error(ArgumentError, "Expected an AnswerSheet, received Quiz")
    end
  end
end
