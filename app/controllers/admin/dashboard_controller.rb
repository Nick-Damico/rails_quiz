class Admin::DashboardController < ApplicationController
  before_action :set_user, only: %i[show]
  before_action :authorize_access!

  def show
  end
end
