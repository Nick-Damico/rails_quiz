require 'rails_helper'

RSpec.describe Deck, type: :model do
  it { should belong_to(:author) }
  it { should have_many(:cards) }

  it { should validate_presence_of(:title) }
end
