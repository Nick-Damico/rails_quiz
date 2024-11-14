require 'rails_helper'

RSpec.describe Quiz, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }

  it { should have_many(:answers) }
end
