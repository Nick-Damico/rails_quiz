class Admin::DashboardController < ApplicationController
  def show
    @user = current_user
    authorize @user
    @tab = (params[:tab].presence || "user").capitalize
    presenter = "Admin::#{@tab}Presenter".safe_constantize
    search_class = "#{@tab}Search".safe_constantize
    # TODO: Add Quiz & Deck admin policy
    default_scope = policy_scope([ :admin, @tab.safe_constantize ])

    search = search_class.new(default_scope, params)

    @pagy, objects = pagy(:countish, search.query)
    @objects = objects.map { |object| presenter.new(object) }
  end

  private
end
