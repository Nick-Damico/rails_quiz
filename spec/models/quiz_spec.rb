require 'rails_helper'

RSpec.describe Quiz, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
  it { should belong_to(:category) }

  it { should have_many(:questions) }

  context "#publish!" do
    let!(:quiz) { create(:quiz, questions_count: 5) }
    it "publishes a publishale quiz by setting the published_at datetime" do
      quiz = create(:quiz, questions_count: 5)

      expect {
        quiz.publish!
      }.to change(quiz, :published_at).from(nil)
    end

    it "does not publish an unpublishable quiz" do
      quiz = create(:quiz, questions_count: 0)

      expect {
      quiz.publish!
    }.not_to change(quiz, :published_at)
    end
  end

  context "#published?" do
    it "returns false if published_at is nil" do
      quiz = build(:quiz, published_at: nil)

      expect(quiz).not_to be_published
    end

    it "returns true if published_at is present" do
      quiz = build(:quiz, published_at: Time.current)

      expect(quiz).to be_published
    end
  end

  context "#publishable?" do
    it "returns false if the quiz has less than 5 questions" do
      quiz = create(:quiz, questions_count: 4)

      expect(quiz).not_to be_publishable
    end

    it "returns true if the quiz has 5 or more questions" do
      quiz = create(:quiz, questions_count: 5)

      expect(quiz).to be_publishable
    end
  end

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

  context "#unpublish!" do
    it "unpublishes a quiz removing its published_at datetime" do
      quiz = create(:quiz, published_at: Time.current)

      expect {
        quiz.unpublish!
      }.to change(quiz, :published_at).to(nil)
    end
  end
end
