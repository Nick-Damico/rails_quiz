class Admin::UsersController < Admin::BaseController
  before_action :set_user, except: %i[index]

  def index
    super

    default_scope = policy_scope([ :admin, User.all.order(:username) ])
    search = UserSearch.new(default_scope, params)

    @user = current_user # maybe remove
    @pagy, users = pagy(:countish, search.query)
    @users = users.map { |user| Admin::UserPresenter.new(user) }
  end

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

  def deactivate
    if @user.deactivate!
      flash[:notice] = t("flash.admin.users.deactivate.success")
      redirect_to admin_dashboard_url(tab: "user")
    else
      flash[:alert] = t("flash.admin.users.deactivate.error")
      redirect_to admin_dashboard_url(tab: "user")
    end
  end

  def activate
    if @user.activate!
      flash[:notice] = t("flash.admin.users.activate.success")
      redirect_to admin_dashboard_url(tab: "user")

    else
      flash[:alert] = t("flash.admin.users.activate.error")
      redirect_to admin_dashboard_url(tab: "user")
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
