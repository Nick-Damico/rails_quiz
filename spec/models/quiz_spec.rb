require 'rails_helper'

RSpec.describe Quiz, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }

  it { should have_many(:questions) }

  context "#time_to_complete" do
    it "returns the total estimated time to complete all cards in seconds" do
      quiz = create(:quiz, questions_count: 2)

      expect(quiz.time_to_complete).to eq(60)
    end

    it "returns 0 with zero questions" do
      quiz = create(:quiz, questions_count: 0)

      expect(quiz.time_to_complete).to eq(0)
    end
  end
end
