class NewsPostsController < ApplicationController
  before_action :get_news_post, only: %i[show]

  def index
    @news_posts = NewsPost.all
  end

  def show
    authorize @news_post
  end

  private

    def get_news_post
      @news_post = NewsPost.find_by_slug(params[:id])
    end
end
