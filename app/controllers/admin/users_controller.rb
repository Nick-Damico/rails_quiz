class Admin::UsersController < Admin::BaseController
  before_action :set_user

  def edit; end

  def update
    if @user.update(user_params)
      if @user.hidden?
        flash[:notice] = "user account deactivated successfully"
      else
        flash[:notice] = "user updated successfully"
      end

      redirect_to admin_dashboard_url(tab: "user")
    else
      flash.now[:alert] = @user.errors.full_messages
      render :edit, status: :unprocessable_content
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :hidden)
    end

    def authorize_admin!
      authorize [ :admin, :user ], :access?
    end

    def set_user
      @user = User.find(params[:id])
    end
end
