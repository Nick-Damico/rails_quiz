require 'rails_helper'

RSpec.describe UserDeck, type: :model do
  let!(:user_deck) { create(:user_deck) }

  it { should belong_to(:user) }
  it { should belong_to(:deck) }
end
