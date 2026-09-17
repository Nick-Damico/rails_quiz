require "rails_helper"

RSpec.describe Admin::UserPresenter do
  let(:user) { create(:user, username: "sam pups", email: "sam_pups@example.com") }
  subject { described_class.new(user) }


  describe "#field_names" do
    it "returns the expected column headers" do
      expect(subject.field_names).to contain_exactly(:username, :email, :created_on, :actions)
    end
  end
  describe "#id" do
    it "returns the user's id" do
      expect(subject.id).to eq(user.id)
    end
  end

  describe "#username" do
    it "returns the user's username" do
      expect(subject.username).to eq("sam pups")
    end
  end

  describe "#created_on" do
    it "returns the user's created_at date formatted as 'YYYY-MM-DD'" do
      expect(subject.created_on).to eq(user.created_at.strftime("%Y-%m-%d"))
    end
  end
  describe "#email" do
    it "returns the user's email" do
      expect(subject.email).to eq("sam_pups@example.com")
    end
  end
end
