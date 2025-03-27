require 'rails_helper'

RSpec.describe Decks::Card, type: :model do
  it { should belong_to(:deck) }

  it { should validate_presence_of(:front) }
  it { should validate_presence_of(:back) }

  context 'scopes' do
    describe '.new_cards(UserDeck)' do
      it 'returns cards that are not in the user deck' do
        user_deck = create(:user_deck, :with_user_deck_cards)
        new_card = create(:card)

        user_deck.deck.cards << new_card

        expect(Decks::Card.new_cards(user_deck)).to eq([ new_card ])
      end
    end
  end
end
