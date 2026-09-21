class Admin::UsersController < Admin::BaseController
  before_action :set_user, except: %i[index]

  def index
    default_scope = policy_scope([ :admin, User.all ])
    search = UserSearch.new(default_scope, params)

    @tab = "user"
    @user = current_user # maybe remove
    @pagy, users = pagy(:countish, search.query)
    @objects = users.map { |user| Admin::UserPresenter.new(user) }
    @user_count = User.count
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
