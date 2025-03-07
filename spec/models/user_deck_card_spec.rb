require 'rails_helper'

RSpec.describe UserDeckCard, type: :model do
  it { should belong_to(:user_deck) }
  it { should belong_to(:card) }
end
