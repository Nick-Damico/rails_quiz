require 'rails_helper'

RSpec.describe StudyPlan, type: :model do
  let!(:study_plan) { create(:study_plan) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
end
