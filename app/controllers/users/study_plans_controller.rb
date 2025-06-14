class Users::StudyPlansController < ApplicationController
  before_action :set_user, only: %i[index]

  def index
    @study_plans = policy_scope([ :users, @user.study_plans ])
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end
end
