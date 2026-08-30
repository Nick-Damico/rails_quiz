require "rails_helper"

RSpec.describe Admin::UserPolicy, type: :policy do
  subject { described_class }

  let(:admin_user) { create(:user, :with_admin) }
  let(:unauthorized_user) { create(:user) }

  permissions ".scope" do
    it "returns all user records" do
      all_users = create_list(:user, 2)
      all_users << admin_user

      result = described_class::Scope.new(admin_user, User).resolve

      expect(result).to contain_exactly(*all_users)
    end
  end
end
