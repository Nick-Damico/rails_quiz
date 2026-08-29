class Admin::DashboardController < ApplicationController
  def show
    @user = current_user
    authorize @user
    @pagy, @resources = pagy(:countish, User.all)
  end

  private
end
