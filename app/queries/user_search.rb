class UserSearch < ApplicationSearch
  def filter_options
    filters = {}
    # filters[:categories] = categories
    filters
  end

  def query
    scope
  end

  private
  # def categories
  #   Category.select(:id, :name, :slug).all.order(:name)
  # end
end
