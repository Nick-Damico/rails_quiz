class UserSearch < ApplicationSearch
  def query
    scope = @scope

    scope = text_query(scope) if text_search.present?
    scope
  end

  def text_query(scope)
    scope.where("LOWER(username) LIKE :text", text: "%#{text_search.downcase}%")
  end

  def text_search
    params[:q]
  end

  private
end
