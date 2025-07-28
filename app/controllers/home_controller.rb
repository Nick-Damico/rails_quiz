class HomeController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :skip_authorizations, only: %i[show]

  def show
  end
end
