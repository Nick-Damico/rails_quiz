require 'rails_helper'

RSpec.describe UserDeck, type: :model do
  include ActiveSupport::Testing::TimeHelpers

  let!(:user_deck) { create(:user_deck, :with_user_deck_cards) }

  it { should belong_to(:user) }
  it { should belong_to(:deck) }
  it { should have_many(:user_deck_cards).dependent(:destroy) }

  describe "#build_user_cards" do
    context "with persisted user_deck" do
      it "builds user_deck_cards for all cards in the deck" do
        expect(user_deck.user_deck_cards.size).to eq(user_deck.cards.size)
      end
    end

    context "without persisted user_deck" do
      it "builds user_deck_cards for all cards in the deck" do
        new_user_deck = build(:user_deck)
        new_user_deck.build_user_cards

        new_user_deck.save!

        expect(new_user_deck.user_deck_cards.size).to eq(new_user_deck.cards.size)
      end
    end

    context "without a deck" do
      it "does not build user_deck_cards" do
        user_deck = build(:user_deck, deck: nil)

        user_deck.build_user_cards

        expect(user_deck.user_deck_cards.size).to be_zero
      end
    end

    context "with cards already built" do
      it "does not build duplicate user_deck_cards" do
        expect(user_deck.user_deck_cards.size).to be > 0

        expect {
          user_deck.build_user_cards
        }.to change(user_deck.user_deck_cards, :count).by(0)
      end

      it "builds user_deck_cards for new cards" do
        user_deck.deck.cards << create(:card)

        user_deck.build_user_cards

        expect { user_deck.save }.to change(user_deck.user_deck_cards, :count).by(1)
      end
    end
  end

  describe "#completed?" do
    it 'returns true if completed_at is timestamped' do
      user_deck.mark_started
      user_deck.mark_completed

      expect(user_deck.completed?).to eq true
    end

    it 'returns false if completed at is not timestamped' do
      expect(user_deck.completed_at).to be_nil

      expect(user_deck.completed?).to eq false
    end
  end

  describe "#completed_in_seconds" do
    it "return the amount of time elapsed in seconds" do
      user_deck.started_at = Time.new(2025, 03, 28, 12, 00)
      user_deck.completed_at = user_deck.started_at + 60.seconds

      expect(user_deck.completed_in_seconds).to eq(60)
    end
  end

  describe "#find_card_by_id_or_fallback" do
    context "with a card_id" do
      it "finds the card by ID in the supplied collection" do
        user_deck_card = user_deck.user_deck_cards.first
        user_deck_cards = user_deck.user_deck_cards

        found_card = user_deck.find_card_by_id_or_fallback(
          user_deck_card.id, user_deck_cards: user_deck_cards
        )

        expect(found_card).to eq(user_deck_card)
      end
    end

    context "without a card_id" do
      it "defaults to returning the first card from the collection if card is not found" do
        first_card = user_deck.user_deck_cards.first
        bad_id = 0

        found_card = user_deck.find_card_by_id_or_fallback(
          bad_id,
          user_deck_cards: user_deck.user_deck_cards
        )

        expect(first_card).to eq(found_card)
      end

      describe "optional :fallback_method" do
        it "allows optional fallback for last card" do
          expect(
            user_deck.find_card_by_id_or_fallback(
              0, user_deck_cards: user_deck.user_deck_cards, fallback_method: :last
            )
          ).to eq(user_deck.user_deck_cards.last)
        end
      end
    end
  end

  describe "#mark_started" do
    it 'sets the started_at time for a review' do
      time_now = Time.current.utc

      freeze_time do
        user_deck.mark_started
      end

      expect(user_deck.started_at.to_s).to eq time_now.to_s
    end
  end

  describe "#mark_completed" do
    it 'sets the completed_at time for a review' do
      time_now = Time.current.utc

      freeze_time do
        user_deck.mark_completed
      end

      expect(user_deck.completed_at.to_s).to eq time_now.to_s
    end
  end

  describe "#score" do
    let(:user_deck) { create(:user_deck, :with_user_deck_cards, deck: create(:deck, card_count: 4)) }
    it "returns 100.0 percent when all cards are correct" do
      user_deck.user_deck_cards.each { |card| card.correct! }
      user_deck.mark_completed

      expect(user_deck.score).to eq 100.0
    end
    it "returns a percentage when not all cards are correct" do
      user_deck.user_deck_cards.first(3).each { |user_deck_card| user_deck_card.correct! }
      user_deck.mark_completed

      expect(user_deck.score).to eq 75.0
    end

    it "returns a score of 0 when user_deck(review) is not completed" do
      expect(user_deck.score).to eq 0
    end
  end
end
