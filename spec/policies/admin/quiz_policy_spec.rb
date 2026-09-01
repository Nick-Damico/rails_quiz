require "rails_helper"

RSpec.describe Admin::QuizPolicy, type: :policy do
  subject { described_class }

  let(:admin_user) { create(:user, :with_admin) }
  let(:unauthorized_user) { create(:user) }

  permissions ".scope" do
    it "returns all user records" do
      all_quizzes = create_list(:quiz, 2)

      result = described_class::Scope.new(admin_user, Quiz).resolve

      expect(result).to contain_exactly(*all_quizzes)
    end
  end
end
