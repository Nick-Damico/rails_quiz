require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of(:quiz) }
  it { should validate_presence_of(:content) }

  it { should belong_to(:quiz) }
  it { should have_many(:choices) }

  context "#validate_number_of_choices" do
    it 'when fewer than 2 choices' do
      invalid_question = Question.new(content: "What is 2 + 2?", quiz: create(:quiz))

      invalid_question.choices << build(:choice, correct: true)

      expect(invalid_question).to be_invalid
      expect(invalid_question.errors[:choices]).to include("must have at least 2 choices")
    end

    it 'when more than 2 choices' do
      valid_question = Question.new(content: "What is 2 + 2?", quiz: create(:quiz))

      valid_question.choices << build(:choice)
      valid_question.choices << build(:choice, correct: true)

      expect(valid_question).to be_valid
    end
  end

  context "#validate_correct_choice" do
    it 'when a correct choice not marked' do
      invalid_question = Question.new(content: "What is 2 + 2?", quiz: create(:quiz))

      invalid_question.choices << build(:choice, correct: false)
      invalid_question.choices << build(:choice, correct: false)

      expect(invalid_question).to be_invalid
      expect(invalid_question.errors[:choices]).to include("must have one choice marked as correct")
    end
  end
end
