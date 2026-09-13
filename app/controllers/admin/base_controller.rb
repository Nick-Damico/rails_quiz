class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  rescue_from Pundit::NotAuthorizedError do
    flash[:alert] = "Access denied."
    redirect_back_or_to root_url
  end

  private

    def authorize_admin!
      authorize :admin, :access?, policy_class: AdminPolicy
    end
end
