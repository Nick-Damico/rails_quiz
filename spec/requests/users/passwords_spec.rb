
require "rails_helper"

RSpec.describe "Users::Passwords", type: :request do
  let!(:user) { create(:user) }

  describe "PATCH /users/password" do
    context "with valid params" do
      it "allows the user to change their password" do
        sign_in(user)
        patch update_password_user_path(user), params: {
          user: {
            current_password: user.password,
            password: "newpassword123!",
            password_confirmation: "newpassword123!"
          }
        }

        expect(response.body).to include("Password successfully updated.")
      end
    end

    context "with invalid params" do
      it "does not allow the user to change their password" do
        sign_in(user)
        patch update_password_user_path(user), params: {
          user: {
            current_password: "badPassword123!",
            password: "newpassword123!",
            password_confirmation: "newpassword123!"
          }
        }

        expect(response.body).to include("There was an error updating the password.")
      end
    end
  end
end
