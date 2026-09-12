require "rails_helper"

RSpec.describe Admin::UsersController, type: :request do
  let(:admin) { create(:user, :with_admin) }
  let(:user) { create(:user) }

  describe "GET /admin/users/:id/edit" do
    context "when not authenticated" do
      before { sign_in user }

      it "redirects to root url with an access denied message" do
        get edit_admin_user_path(create(:user))

        expect(response).to redirect_to(root_url)
        expect(flash[:alert]).to eq("Access denied.")
      end
    end

    context "when authenticated as admin" do
      before do
        sign_in admin
      end

      it "responds successfully" do
        get edit_admin_user_path(user)

        expect(response).to have_http_status(:success)
      end
    end
  end
end
