require "rails_helper"

RSpec.describe Author::DeckPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:unauthorized_user) { create(:user) }

  permissions "Scope#resolve" do
    let!(:owned_deck) { create(:deck, author: user) }
    let!(:unowned_deck) { create(:deck) }
    it "returns all decks for the author" do
      expect(
        described_class::Scope.new(user, Deck).resolve
      ).to contain_exactly(owned_deck)
    end
  end

  permissions :new? do
    let(:record) { build(:deck, author: user) }
    it "allows the author to access the new deck form" do
      expect(subject).to permit(user, record)
    end

    it "prevents unauthorized access of the new deck form" do
      expect(subject).not_to permit(unauthorized_user, record)
    end
  end

  permissions :create? do
    let(:record) { build(:deck, author: user) }
    it "allows the user to authorize the creation of a deck" do
      expect(subject).to permit(user, record)
    end

    it "prevents a user from authoring a deck for another user" do
      expect(subject).not_to permit(unauthorized_user, record)
    end
  end

  permissions :show? do
    let(:record) { create(:deck, author: user) }

    it "allows an author to access their deck" do
      expect(subject).to permit(user, record)
    end

    it "prevents unauthorized access to another author's deck" do
      expect(subject).to_not permit(unauthorized_user, record)
    end
  end

  permissions :edit? do
    let(:record) { create(:deck, author: user) }

    it "allows the author to access the edit deck form" do
      expect(subject).to permit(user, record)
    end
    it "prevents unauthorized access of the edit deck form" do
      expect(subject).not_to permit(unauthorized_user, record)
    end
  end

  permissions :update? do
    let(:record) { create(:deck, author: user) }

    it "allows the author to update their deck" do
      expect(subject).to permit(user, record)
    end

    it "prevents unauthorized updating of another author's deck" do
      expect(subject).to_not permit(unauthorized_user, record)
    end
  end

  permissions :destroy? do
    let(:record) { create(:deck, author: user) }
    it "allows an author to delete their deck" do
      expect(subject).to permit(user, record)
    end

    it "prevents a user from deleting an author's deck" do
      expect(subject).to_not permit(unauthorized_user, record)
    end
  end
end
