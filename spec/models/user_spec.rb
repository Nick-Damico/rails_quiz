require 'rails_helper'

RSpec.describe User, type: :model do
  it 'simple test' do
    password = Faker::Internet.password
    expect(true).to eq true
  end
end
