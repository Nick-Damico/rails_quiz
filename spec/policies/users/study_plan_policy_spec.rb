require "rails_helper"

RSpec.describe Users::StudyPlanPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:study_plans) { create_list(:study_plan, 2, user: user) }

  permissions "Scope#resolve" do
    it "returns all study_plans" do
      expect(described_class::Scope.new(user, StudyPlan).resolve).to contain_exactly(*study_plans)
    end
  end

  permissions :show?, :new?, :create? do
    it "permits authenticated user access" do
      expect(subject).to permit(user, study_plans.first)
    end
    it "prevents unauthenticated user access" do
      expect(subject).to_not permit(build(:user), study_plans.first)
    end
  end
end
