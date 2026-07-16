class HomeController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :skip_authorizations, only: %i[show]

  def show
    if user_signed_in?
      @study_plans = current_user.study_plans.order(:name)
    end
  end
end
