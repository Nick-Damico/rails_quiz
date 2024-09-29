require 'rails_helper'

RSpec.describe Quiz, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:author) }
end
