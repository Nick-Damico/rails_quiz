require 'rails_helper'

RSpec.describe Quiz, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }

  it { should have_many(:questions) }

  context "#time_to_complete" do
    it "displays estimated time to complete" do
      quiz = build(:quiz, questions_count: 2)

      est_time = quiz.time_to_complete

      expect(est_time).to_not be_nil
      expect(est_time).to be_a(Integer)
    end

    it "estimates 30 secs per question" do
      quiz = create(:quiz, questions_count: 2)

      expect(quiz.time_to_complete).to eq(1)
    end

    it "rounds up to the nearest whole number" do
      quiz = create(:quiz, questions_count: 3)

      expect(quiz.time_to_complete).to eq(2)
    end
  end
end
