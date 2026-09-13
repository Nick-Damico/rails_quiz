class Admin::UsersController < Admin::BaseController
  before_action :set_user

  def edit; end

  def update
    if @user.update(user_params)
      flash.now[:success] = "user updated successfully"
      render :edit, status: :ok
    else
      flash.now[:alert] = @user.errors.full_messages
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
  end

  private

    def user_params
      params.require(:user).permit(:username, :email)
    end

    def authorize_admin!
      authorize [ :admin, :user ], :access?
    end

    def set_user
      @user = User.find(params[:id])
    end
end
