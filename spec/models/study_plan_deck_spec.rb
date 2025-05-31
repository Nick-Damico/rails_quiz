require 'rails_helper'

RSpec.describe StudyPlanDeck, type: :model do
  let!(:study_plan) { create(:study_plan_deck) }

  it { should belong_to(:study_plan) }
  it { should belong_to(:deck) }

  it { should validate_uniqueness_of(:deck_id)
              .scoped_to(:study_plan_id)
              .with_message("Deck already added to this study plan") }
end
