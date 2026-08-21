class HomeController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :skip_authorizations, only: %i[show]

  def show
    return unless user_signed_in?

    @study_plans = StudyPlan.includes(:decks, :quizzes).where(user: current_user).order(:name).limit(5)
    @news_posts = NewsPost.all
  end
end
