require "rails_helper"

RSpec.describe Questions::ChoicePolicy, type: :policy do
  subject { described_class }

  let(:author) { create(:user) }
  let(:unauthorized_user) { create(:user) }
  let(:quiz) { create(:quiz, author: author) }
  let(:choice) { create(:choice, question: quiz.questions.first) }

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

  permissions :new?, :create? do
    it "permits access to create a new question choice" do
      expect(subject).to permit(author, choice)
    end

    it "prevents users from creating a flash card for another author's deck" do
      expect(subject).to_not permit(unauthorized_user, choice)
    end
  end

  permissions :edit?, :update? do
    it "permits access to edit a question choice" do
      expect(subject).to permit(author, choice)
    end

    it "prevents users from editing a choice for another author's question" do
      expect(subject).to_not permit(unauthorized_user, choice)
    end
  end

  permissions :destroy? do
    it "permits the author to a question choice" do
      expect(subject).to permit(author, choice)
    end

    it "prevents users from deleting a choice for another author's question" do
      expect(subject).to_not permit(unauthorized_user, choice)
    end
  end
end
