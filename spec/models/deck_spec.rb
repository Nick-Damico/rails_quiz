require 'rails_helper'

RSpec.describe Deck, type: :model do
  it { should belong_to(:author) }
  it { should have_many(:cards) }
  it { should belong_to(:category) }
  it { should have_many(:user_decks) }

  it { should validate_presence_of(:title) }

  describe ".published" do
    it "returns only published quizzes" do
      published = create(:deck, :with_publishable, published_at: Time.current)
      create(:deck)

      expect(described_class.published).to contain_exactly(published)
    end
  end

  describe "#publish!" do
    let!(:deck) { create(:deck, card_count: 5) }
    it "publishes a publishale quiz by setting the published_at datetime" do
      deck = create(:deck, card_count: 5)

      expect {
        deck.publish!
      }.to change(deck, :published_at).from(nil)
    end

    it "does not publish an unpublishable quiz" do
      deck = create(:deck, card_count: 0)

      expect {
      deck.publish!
    }.not_to change(deck, :published_at)
    end
  end

  describe "#published?" do
    it "returns false if published_at is nil" do
      deck = build(:deck, published_at: nil)

      expect(deck).not_to be_published
    end

    it "returns true if published_at is present" do
      deck = build(:deck, published_at: Time.current)

      expect(deck).to be_published
    end
  end

  describe "#publishable?" do
    it "returns false if the quiz has less than 5 cards" do
      deck = create(:deck, card_count: 4)

      expect(deck).not_to be_publishable
    end

    it "returns true if the quiz has 5 or more cards" do
      deck = create(:deck, card_count: 5)

      expect(deck).to be_publishable
    end
  end
  describe "#time_to_complete" do
    it "returns the total estimated time to complete all cards in seconds" do
      # TODO: hard coded time per card, will make configurable later
      deck = create(:deck, card_count: 2)

      expect(deck.time_to_complete).to eq(30)
    end

    it "returns 0 for a deck with no cards" do
      deck = create(:deck, card_count: 0)

      expect(deck.time_to_complete).to eq(0)
    end
  end

  describe "#unpublish!" do
    it "unpublishes a quiz removing its published_at datetime" do
      deck = create(:deck, published_at: Time.current)

      expect {
        deck.unpublish!
      }.to change(deck, :published_at).to(nil)
    end
  end
end
