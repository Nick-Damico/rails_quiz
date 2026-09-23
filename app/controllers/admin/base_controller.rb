class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  rescue_from Pundit::NotAuthorizedError do
    flash[:alert] = "Access denied."
    redirect_back_or_to root_url
  end

  def index
    # navigation tabs
    @tab = params[:tab].presence || "user"
    @user_count = User.count
    @deck_count = Deck.count
    @quiz_count = Quiz.count
  end

  private

    def authorize_admin!
      authorize :admin, :access?, policy_class: AdminPolicy
    end
end
