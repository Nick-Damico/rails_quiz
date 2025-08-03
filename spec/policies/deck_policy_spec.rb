require "rails_helper"

RSpec.describe DeckPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:decks) { create_list(:deck, 2) }

  permissions "Scope#resolve" do
    it "returns all decks" do
      expect(described_class::Scope.new(user, Deck).resolve).to contain_exactly(*decks)
    end
  end

  permissions :show? do
    it "permits authenticated user access" do
      expect(subject).to permit(user, decks.first)
    end

    it "prevents unauthenticated user access" do
      expect(subject).to_not permit(build(:user), decks.first)
    end
  end
end
