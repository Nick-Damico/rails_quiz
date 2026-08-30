class Admin::DashboardController < ApplicationController
  def show
    @user = current_user
    authorize @user
    default_scope = policy_scope([ :admin, User ])
    search = UserSearch.new(default_scope, params)

    @pagy, @resources = pagy(:countish, search.query)
  end

  private
end
