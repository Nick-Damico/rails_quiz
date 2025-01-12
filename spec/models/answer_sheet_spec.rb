require 'rails_helper'

RSpec.describe AnswerSheet, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:quiz) }
  it { should have_many(:answer_sheet_questions) }
end
