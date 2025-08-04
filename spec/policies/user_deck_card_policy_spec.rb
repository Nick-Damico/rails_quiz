require "rails_helper" 

RSpec.describe UserDeckCardPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:user_deck_card) do
    create(:user_deck_card, user_deck: create(:user_deck, user: user))
  end

  permissions :update? do
    it "permits authenticated user access" do
      expect(subject).to permit(user, user_deck_card)
    end

    it "prevents unauthenticated user access" do
      expect(subject).to_not permit(build(:user), user_deck_card)
    end
  end
end