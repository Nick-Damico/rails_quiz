require "rails_helper"

RSpec.describe UserSearch, type: :model do
  let(:user_1) { create(:user, username: "Sam Pups") }
  let(:user_2) { create(:user, username: "Johnny Appleseed") }
  describe "#query" do
    it "returns users matching the search query" do
      params = ActionController::Parameters.new({ q: "sam" })
      search = UserSearch.new(User.all, params)

      expect(search.query).to contain_exactly(user_1)
    end
  end
end
