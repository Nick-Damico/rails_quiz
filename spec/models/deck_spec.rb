require 'rails_helper'

RSpec.describe Deck, type: :model do
  it { should belong_to(:author) }
  it { should have_many(:cards) }

  it { should validate_presence_of(:title) }

  describe "#time_to_complete" do
    it "returns the total estimated time to complete all cards in seconds" do
      deck = create(:deck, card_count: 2)

      expect(deck.time_to_complete).to eq(20)
    end

    it "returns 0 for a deck with no cards" do
      deck = create(:deck, card_count: 0)

      expect(deck.time_to_complete).to eq(0)
    end
  end
end
