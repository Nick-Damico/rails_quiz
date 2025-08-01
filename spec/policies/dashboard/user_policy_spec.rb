require "rails_helper"

RSpec.describe Dashboard::UserPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:unauthorized_user) { create(:user) }

  permissions :show?, :update? do
    it "permits authenticated user access" do
      expect(subject).to permit(user, user)
    end

    it "prevents access to other users' profiles" do
      expect(subject).to_not permit(unauthorized_user, user)
    end
  end
end