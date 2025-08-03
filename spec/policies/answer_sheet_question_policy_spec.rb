require "rails_helper"

RSpec.describe AnswerSheetQuestionPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:unauthorized_user) { create(:user) }
  let(:answer_sheet_question) {
    create(:answer_sheet_question, answer_sheet: create(:answer_sheet, user: user))
  }

  permissions :show?, :update? do
    it "permits the owner of the answer sheet" do
      expect(subject).to permit(user, answer_sheet_question)
    end

    it "prevents unauthorized user access" do
      expect(subject).to_not permit(unauthorized_user, answer_sheet_question)
    end
  end
end
