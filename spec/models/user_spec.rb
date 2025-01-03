require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:authored_quizzes) }

  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:username) }
end
