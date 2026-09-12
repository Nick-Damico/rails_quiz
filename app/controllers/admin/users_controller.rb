class Admin::UsersController < Admin::BaseController
  before_action :set_user

  def edit; end

  def update; end

  def destroy
  end

  private

    def authorize_admin!
      authorize [ :admin, :user ], :access?
    end

    def set_user
      @user = User.find(params[:id])
    end
end
