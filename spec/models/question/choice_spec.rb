require 'rails_helper'

RSpec.describe Question::Choice, type: :model do
  it { should belong_to(:question).required(true) }

  it { should validate_presence_of(:content) }
  it { should validate_inclusion_of(:correct).in_array([ true, false ]) }
end
