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

  describe "PATCH /admin/users/:id" do
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

      context "with valid params" do
        it "responds with status code of ok" do
          patch admin_user_path(user), params: { user: { username: "sammy pups" } }

          expect(response).to have_http_status(:ok)
        end

        it "updates the information" do
          patch admin_user_path(user), params: { user: { username: "sammy pups", email: "new_pups@example.com" } }

          user.reload
          expect(response).to have_http_status(:ok)
          expect(user.username).to eq("sammy pups")
          expect(user.unconfirmed_email).to eq("new_pups@example.com")
        end
      end
      context "with invalid params" do
        it "responds with status code of unprocessable content" do
          patch admin_user_path(user), params: { user: { username: "" } }

          expect(response).to have_http_status(:unprocessable_content)
        end

        it "does not update the users information" do
          original_username = user.username

          patch admin_user_path(user), params: { user: { username: "" } }

          expect(user.reload.username).to eq(original_username)
        end
      end
    end
  end
end
