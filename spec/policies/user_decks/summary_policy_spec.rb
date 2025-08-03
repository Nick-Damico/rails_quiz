
require "rails_helper"

RSpec.describe UserDecks::SummaryPolicy, type: :policy do
  subject { described_class }

  let(:author) { create(:user) }
  let(:unauthorized_user) { create(:user) }
  let(:user_deck) {
    create(:user_deck, :with_completed, user: author)
  }

  permissions :show? do
    it "permits access to flashcard deck test results" do
      expect(subject).to permit(author, user_deck)
    end

    it "prevents unauthorized access to another users test results" do
      expect(subject).to_not permit(unauthorized_user, user_deck)
    end
  end
end
