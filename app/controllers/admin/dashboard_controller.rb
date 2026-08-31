class Admin::DashboardController < ApplicationController
  def show
    @user = current_user
    authorize @user
    default_scope = policy_scope([ :admin, User ])
    search = UserSearch.new(default_scope, params)

    @pagy, objects = pagy(:countish, search.query)
    @objects = objects.map { |user| Admin::UserPresenter.new(user) }
  end

  private
end
