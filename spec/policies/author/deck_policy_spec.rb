require "rails_helper"

RSpec.describe Author::DeckPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }

  permissions "Scope#resolve" do
    let!(:owned_deck) { create(:deck, author: user) }
    let!(:unowned_deck) { create(:deck) }
    it "returns all decks for the author" do
      expect(
        described_class::Scope.new(user, Deck).resolve
      ).to contain_exactly(owned_deck)
    end
  end
end
