require 'rails_helper'

RSpec.describe UserDeck, type: :model do
  let!(:user_deck) { create(:user_deck) }

  it { should belong_to(:user) }
  it { should belong_to(:deck) }
  it { should have_many(:user_deck_cards).dependent(:destroy) }
end
