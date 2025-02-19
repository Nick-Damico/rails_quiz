require 'rails_helper'

RSpec.describe Decks::Card, type: :model do
  it { should belong_to(:deck) }

  it { should validate_presence_of(:front) }
  it { should validate_presence_of(:back) }
end
