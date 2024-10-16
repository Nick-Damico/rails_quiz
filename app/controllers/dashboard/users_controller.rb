class Dashboard::UsersController < ApplicationController
  before_action :set_user, only: %i[show update]

  def show
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile Updated"
    end

    redirect_to dashboard_user_url(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username)
  end
end
