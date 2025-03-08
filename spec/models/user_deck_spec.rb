require 'rails_helper'

RSpec.describe UserDeck, type: :model do
  let!(:user_deck) { create(:user_deck) }

  it { should belong_to(:user) }
  it { should belong_to(:deck) }
  it { should have_many(:user_deck_cards).dependent(:destroy) }

  describe "#build_user_cards" do
    context "with persisted user_deck" do
      it "builds user_deck_cards for all cards in the deck" do
        user_deck.build_user_cards

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
  end
end
