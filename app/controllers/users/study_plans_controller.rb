class Users::StudyPlansController < ApplicationController
  before_action :set_user, only: %i[index new create]

  def index
    @study_plans = policy_scope([ :users, @user.study_plans ])
  end

  def new
    @study_plan = authorize([ :users, @user.study_plans.new ])
  end

  def create
    @study_plan = authorize([ :users, @user.study_plans.new(study_plan_params) ])
    if @study_plan.save
      redirect_to user_study_plan_path(@user, @study_plan), notice: t("flash.study_plans.create.success")
    else
      flash.now[:alert] = t("flash.study_plans.create.error")
      render :new, status: :unprocessable_entity
    end
  end


  private
    def study_plan_params
      params.require(:study_plan).permit(:name, :description)
    end

    def set_user
      @user = User.find(params[:user_id])
    end
end
