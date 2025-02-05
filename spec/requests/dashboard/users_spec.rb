require 'rails_helper'

RSpec.describe "Dashboard::Users", type: :request do
  let!(:user) { create(:user) }

  before { sign_in user }

  describe "GET /show" do
    it "is returns an http success status" do
      get dashboard_user_path(user)

      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT /update" do
    it "updates the users username" do
      new_username = "SamPuppies"

      put dashboard_user_path(user), params: { user: { username: new_username } }

      expect(user.reload.username). to eq new_username
    end
  end
end
