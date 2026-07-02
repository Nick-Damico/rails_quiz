class DeckSearch < ApplicationSearch
  def filter_options
    filters = {}
    filters[:categories] = categories
    filters
  end

  def query
    if params.dig(:category_ids).present?
      @scope = scope.where(category_id: params.dig(:category_ids))
    end

    scope
  end

  private
    def categories
      Category.select(:id, :name, :slug).all.order(:name)
    end
end
