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
        it "redirects to admin dashboard" do
          patch admin_user_path(user), params: { user: { username: "sammy pups" } }

          expect(response).to redirect_to(admin_dashboard_url(tab: "user"))
        end

        it "updates the information" do
          patch admin_user_path(user), params: { user: { username: "sammy pups", email: "new_pups@example.com" } }

          user.reload
          expect(user.username).to eq("sammy pups")
          expect(user.unconfirmed_email).to eq("new_pups@example.com")
        end

        context "when deactivating a users account" do
          it "sets the user to hidden" do
            patch admin_user_path(user), params: { user: { hidden: "1" } }

            user.reload
            expect(user).to be_hidden
          end
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

  describe "PATCH /admin/users/:id/deactivate" do
    before { sign_in admin }

    context "successful deactivate" do
      it "deactivates & hides the users' account" do
        patch deactivate_admin_user_path(user)

        expect(user.reload).to be_inactive
        expect(flash[:notice]).to eq("User account was successfully deactivated.")
      end
    end

    context "failure to deactivate" do
      it "does not deactivate the users' account" do
        allow(User).to receive(:find).with(user.id.to_s).and_return(user)
        allow(user).to receive(:deactivate!).and_return(false)

        patch deactivate_admin_user_path(user)

        expect(user.reload).not_to be_inactive
        expect(flash[:alert]).to eq("There was an error deactivating this users account. Refresh page and try again.")
      end
    end
  end
  describe "PATCH /admin/users/:id/activate" do
    before { sign_in admin }

    context "successful" do
      it "activates an inactive user account" do
        user.deactivate!

        patch activate_admin_user_path(user)

        expect(user.reload).to be_active
        expect(flash[:notice]).to eq("User account was successfully activated.")
      end
    end

    context "failure to deactivate" do
      it "does not deactivate the users' account" do
        allow(User).to receive(:find).with(user.id.to_s).and_return(user)
        allow(user).to receive(:activate!).and_return(false)

        user.deactivate!

        patch activate_admin_user_path(user)

        expect(user.reload).to be_inactive
        expect(flash[:alert]).to eq("There was an error activating this users account. Refresh page and try again.")
      end
    end
  end
end
