require 'rails_helper'

RSpec.describe Author::QuizPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:unauthorized_user) { create(:user) }

  permissions "Scope#resolve" do
    let!(:owned_quiz) { create(:quiz, author: user) }
    let!(:unowned_quiz) { create(:quiz) }
    it "returns all quizzes for the author" do
      expect(
        described_class::Scope.new(user, Quiz).resolve
      ).to contain_exactly(owned_quiz)
    end
  end

  permissions :new? do
    let(:record) { build(:quiz, author: user) }
    it "allows the author to access the new quiz form" do
      expect(subject).to permit(user, record)
    end

    it "prevents unauthorized access of the new quiz form" do
      expect(subject).not_to permit(unauthorized_user, record)
    end
  end

  permissions :create? do
    let(:record) { build(:quiz, author: user) }
    it "allows the user to authorize the creation of a quiz" do
      expect(subject).to permit(user, record)
    end

    it "prevents a user from authoring a quiz for another user" do
      expect(subject).not_to permit(unauthorized_user, record)
    end
  end

  permissions :show? do
    let(:record) { create(:quiz, author: user) }
    it "allows an author to access their own quiz" do
      expect(subject).to permit(user, record)
    end

    it "denies access to another author's quiz" do
      expect(subject).to_not permit(unauthorized_user, record)
    end
  end

  permissions :edit? do
    let(:record) { create(:quiz, author: user) }
    it "allows the author to access the edit quiz form" do
      expect(subject).to permit(user, record)
    end

    it "prevents unauthorized access of the edit quiz form" do
      expect(subject).not_to permit(unauthorized_user, record)
    end
  end

  permissions :update? do
    let(:record) { create(:quiz, author: user) }
    it "allows the author to update their quiz" do
      expect(subject).to permit(user, record)
    end

    it "prevents a user from updating an author's quiz" do
      expect(subject).to_not permit(unauthorized_user, record)
    end
  end

  permissions :destroy? do
    let(:record) { create(:quiz, author: user) }
    it "allows an author to delete their quiz" do
      expect(subject).to permit(user, record)
    end

    it "prevents a user from deleting an author's quiz" do
      expect(subject).to_not permit(unauthorized_user, record)
    end
  end
end
