require "rails_helper"

RSpec.describe QuizPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:quizzes) { create_list(:quiz, 2) }

  permissions "Scope#resolve" do
    it "returns all quizzes" do
      expect(described_class::Scope.new(user, Quiz).resolve).to contain_exactly(*quizzes)
    end
  end

  permissions :show? do
    it "permits authenticated user access" do
      expect(subject).to permit(user, quizzes.first)
    end

    it "prevents unauthenticated user access" do
      expect(subject).to_not permit(build(:user), quizzes.first)
    end
  end
end
