class HomeController < ApplicationController
  # TODO: Make this a show route.
  def index
    skip_authorizations
  end
end
