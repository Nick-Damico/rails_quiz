require "rails_helper"

RSpec.describe QuestionHelper, type: :helper do
  describe "#num_to_letter" do
    it 'converts a number to a letter' do
      expect(num_to_letter(0)).to eq 'a'
    end

    it 'handles String representations of numbers without error' do 
      expect(num_to_letter('0')).to eq 'a'
    end

    context 'alphabetical letter range' do
      it 'returns nil for negative numbers less than the range' do
        expect(num_to_letter(-1)).to be_nil
      end

      it 'returns nil for numbers greater than the range' do
        expect(num_to_letter(27)).to be_nil
      end

      it 'returns the letter within the range' do
        expect(num_to_letter(25)).to eq 'z'
      end
    end
  end

  describe "#prev_question_id" do
    let!(:quiz) { create(:quiz, questions_count: 3) }

    context "relative to current question" do
      it 'returns the previous question id' do
        middle_question = quiz.questions[1]
        question_ids = quiz.questions.pluck(:id)

        prev_id = prev_question_id(middle_question, question_ids)

        expect(prev_id).to eq question_ids.first
      end

      it "returns the first question ID if it's last question" do
        first_question = quiz.questions[0]
        question_ids = quiz.questions.pluck(:id)

        prev_id = prev_question_id(first_question, question_ids)

        expect(prev_id).to eq question_ids.last
      end
    end
  end

  describe "#next_question_id" do
    let!(:quiz) { create(:quiz, questions_count: 3) }

    context "relative to current question" do
      it 'returns the previous question id' do
        middle_question = quiz.questions[1]
        question_ids = quiz.questions.pluck(:id)

        next_id = next_question_id(middle_question, question_ids)

        expect(next_id).to eq question_ids.last
      end

      it 'returns the last question ID if no previous' do
        last_question = quiz.questions.last
        question_ids = quiz.questions.pluck(:id)

        next_id = next_question_id(last_question, question_ids)

        expect(next_id).to eq question_ids.first
      end
    end
  end
end
