class QuizSearch < ApplicationSearch
  def filter_options
    filters = {}
    filters[:categories] = categories
    filters
  end

  def query
    @scope = text_query(scope) if text_search.present?

    return @scope unless filter_category_ids.present?

    @scope = scope.where(category_id: filter_category_ids)

    scope
  end

  def text_query(scope)
    text = text_search.downcase
    scope.where("LOWER(title) LIKE :text", text: "%#{text}%")
         .or(scope.where("LOWER(description) LIKE :text", text: "%#{text}%"))
  end

  private
    def categories
      Category.select(:id, :name, :slug).all.order(:name)
    end
end
