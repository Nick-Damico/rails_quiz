require "rails_helper"

RSpec.describe Admin::UsersController, type: :request do
  let(:admin) { create(:user, :with_admin) }
  let(:user) { create(:user) }

  describe "GET /admin/users/:id/edit" do
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
