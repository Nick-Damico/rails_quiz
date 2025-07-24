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
    it "updates the users username" do
      new_username = "Sam Puppies"

      put dashboard_user_path(user), params: { user: { username: new_username } }

      expect(user.reload.username). to eq new_username
    end

    context "avatar upload" do
      it "attaches an avatar image file" do
        avatar_filename = "avatar_1.jpg"
        put dashboard_user_path(user),
          params: {
            user: {
              avatar: fixture_file_upload(Rails.root.join("spec", "fixtures", "files", avatar_filename), "image/jpeg")
            }
          }

        expect(user.reload.avatar).to be_attached
        expect(user.avatar.filename).to eq avatar_filename
      end
    end
  end
end
