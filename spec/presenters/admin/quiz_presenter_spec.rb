require "rails_helper"

RSpec.describe Admin::QuizPresenter do
  let(:user) { create(:user, username: "sam pups", email: "sam_pups@example.com") }
  let(:quiz) {
    create(:quiz, title: "CS 101", description: "Intro to Computer Science", created_at: Date.new(2026, 1, 1))
  }
  subject { described_class.new(quiz) }


  describe "#field_names" do
    it "returns the expected column headers" do
      expect(subject.field_names).to contain_exactly(:username, :email, :created_on, :actions)
    end
  end

  describe "#title" do
    it "returns the quiz's title" do
      expect(subject.title).to eq("CS 101")
    end
  end

  describe "#created_on" do
    it "returns the quiz's created_at date formatted as 'YYYY-MM-DD'" do
      expect(subject.created_on).to eq("2026-01-01")
    end
  end
  describe "#description" do
    it "returns the quiz's description" do
      expect(subject.description).to eq("Intro to Computer Science")
    end
  end
end
