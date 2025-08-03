require "rails_helper"

RSpec.describe QuestionPolicy, type: :policy do
  subject { described_class }

  let(:author) { create(:user) }
  let(:unauthenticated_user) { create(:user) }
  let(:question) { create(:question, quiz: create(:quiz, author: author)) }

  permissions :show?, :new?, :create?, :edit?, :update?, :destroy? do
    it "permits author access" do
      expect(subject).to permit(author, question)
    end

    it "prevents unauthenticated non-author access" do
      expect(subject).to_not permit(unauthenticated_user, question)
    end
  end
end
