class Dashboard::UsersController < ApplicationController
  before_action :set_user, only: %i[show update public_profile]
  before_action :authorize_access!
  before_action :set_breadcrumbs, only: %i[public_profile]

  TABS = %w[quiz deck].freeze

  def show; end

  def public_profile
    authorize([ :dashboard, current_user ])

    @tab = params[:tab]
    @tab = "quiz" unless TABS.include?(@tab)

    scope = @user.send("authored_#{@tab.pluralize}")
                 .published
                 .includes(:category)
                 .select(:id, :title, :description, :category_id, categories: [ :name ])

    search = "#{@tab.capitalize}Search".safe_constantize.new(scope, params)

    @pagy, @resources = pagy(:countish, search.query)
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile Updated"
    end

    redirect_to dashboard_user_url(@user)
  end

  private

    def authorize_access!
      authorize([ :dashboard, @user ])
    end

    def set_breadcrumbs
      if action_name == "public_profile"
        add_breadcrumb "Public Profile"
        add_breadcrumb @user.username
      end
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :avatar, :bio)
    end
end
