class Users::PasswordsController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = current_user
    authorize(@user, policy_class: Dashboard::UserPolicy)
    if @user.update_with_password(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      flash[:notice] = t("flash.users.passwords.update.success")
    else
      flash.now[:alert] = t("flash.users.passwords.update.error")
    end

    render "dashboard/users/show"
  end

  private

    def user_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
end
