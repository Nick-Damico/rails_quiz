require "rails_helper"

RSpec.describe Decks::CardPolicy, type: :policy do
  subject { described_class }

  let(:author) { create(:user) }
  let(:deck) { create(:deck, author: author) }
  let(:card) { create(:card, deck: deck) }
  let(:unauthorized_user) { create(:user) }

  # permissions "Scope#resolve" do
  #   let(:owned_card) { create(:card, deck: deck) }
  #   let(:unowned_deck) { create(:deck, author: unauthorized_user) }
  #   let(:unowned_card) { create(:card, deck: unowned_deck) }

  #   it "returns all cards from an author's deck" do
  #     expect(
  #       described_class::Scope.new(author, Card).resolve
  #     ).to contain_exactly(owned_card)
  #   end
  # end

  permissions :show? do
    it "permits author to access a flash card" do
      expect(subject).to permit(author, card)
    end

    it "prevents access to another author's flash card" do
      expect(subject).to_not permit(unauthorized_user, card)
    end
  end

  permissions :new?, :create? do
    it "permits access to create a new flash card" do
      expect(subject).to permit(author, card)
    end

    it "prevents users from creating a flash card for another author's deck" do
      expect(subject).to_not permit(unauthorized_user, card)
    end
  end

  permissions :edit?, :update? do
    it "permits access to edit a flash card" do
      expect(subject).to permit(author, card)
    end

    it "prevents users from editing a flash card for another author's deck" do
      expect(subject).to_not permit(unauthorized_user, card)
    end
  end

  permissions :destroy? do
    it "permits the author to delete a flash card" do
      expect(subject).to permit(author, card)
    end

    it "prevents users from deleting a flash card for another author's deck" do
      expect(subject).to_not permit(unauthorized_user, card)
    end
  end
end
