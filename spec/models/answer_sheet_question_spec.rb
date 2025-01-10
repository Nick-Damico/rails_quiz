require 'rails_helper'

RSpec.describe AnswerSheetQuestion, type: :model do
  it { should belong_to(:question) }
  it { should belong_to(:answer_sheet) }
  it { should belong_to(:answer).optional(true) }
end
