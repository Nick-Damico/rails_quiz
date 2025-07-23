require 'rails_helper'

RSpec.describe "Dashboard::Users", type: :request do
  let!(:user) { create(:user) }

  before { sign_in user }

  describe "GET /show" do
    it "returns an http status(success)" do
      get dashboard_user_path(user)

      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT /update" do
    it "updates the users information" do
      new_username = "Sam Pups"
      bio = "A pups learning a few things."

      put dashboard_user_path(user), params: { user: { username: new_username, bio: } }

      expect(user.reload.username). to eq new_username
      expect(user.reload.bio). to eq bio
    end

    context "avatar upload" do
      it "attaches an avatar image file" do
        put dashboard_user_path(user),
          params: {
            user: {
              avatar: fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "avatar.jpg"), "image/jpeg")
            }
          }

        expect(user.reload.avatar).to be_attached
        expect(user.avatar.filename).to eq "avatar.jpg"
      end
    end
  end
end
