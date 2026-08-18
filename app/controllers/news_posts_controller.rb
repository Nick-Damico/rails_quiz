class NewsPostsController < ApplicationController
  before_action :get_news_post, only: %i[show]
  before_action :set_breadcrumbs, only: %i[show]

  def index
    @news_posts = NewsPost.sort_by_date
  end

  def show
    authorize @news_post
  end

  private

    def set_breadcrumbs
      add_breadcrumb("News Posts", root_path)
      add_breadcrumb(@news_post.title, news_post_path(@news_post))
    end

    def get_news_post
      @news_post = NewsPost.find_by_slug(params[:id])
    end
end
