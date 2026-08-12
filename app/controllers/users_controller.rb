class UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  before_action :set_breadcrumbs, only: %i[show]
  before_action :authorize_access!

  TABS = %w[quiz deck].freeze

  def show
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


  private

    def authorize_access!
      authorize(current_user)
    end

    def set_breadcrumbs
      add_breadcrumb("Home", root_path)
      if action_name == "show"
        add_breadcrumb "Public Profile"
        add_breadcrumb @user.username
      end
    end

    def set_user
      @user = User.find(params[:id])
    end
end
