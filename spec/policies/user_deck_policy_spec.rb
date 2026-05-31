require 'rails_helper'

RSpec.describe UserDeckPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:unauthorized_user) { create(:user) }
  let(:record) { create(:user_deck, user: user) }

  permissions ".scope" do
    let!(:owned_user_deck) { create(:user_deck, user: user) }
    let!(:unauthorized_user_deck) { create(:user_deck, user: unauthorized_user) }
    it "returns all user decks for the user" do
      expect(described_class::Scope.new(user, UserDeck).resolve).to contain_exactly(owned_user_deck)
    end
  end

  permissions :show? do
    it "allows user to access their own deck" do
      expect(subject).to permit(user, record)
    end

    it "denies access to another user's deck" do
      expect(subject).to_not permit(unauthorized_user, record)
    end
  end

  permissions :create? do
    it "permits a user to start reviewing a deck by creating a UserDeck" do
      expect(subject).to permit(user, record)
    end

    it "prevents users from creating UserDecks for other users" do
      expect(subject).to_not permit(unauthorized_user, record)
    end
  end

  permissions :update? do
    it "allows the user to mark the UserDeck as completed" do
      expect(subject).to permit(user, record)
    end

    it "prevents users from marking the UserDeck as completed for another user" do
      expect(subject).to_not permit(unauthorized_user, record)
    end
  end
end
