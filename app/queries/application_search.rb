class ApplicationSearch
  attr_reader :scope

  def initialize(scope, params)
    unless params.is_a?(ActionController::Parameters)
      raise "params requires an instance of ActionController::Parameters"
      return
    end

    @scope = scope
    @params = params
  end

  def params
    self.safe_params
  end

  def query
    scope
  end

  def filter_category_ids
    safe_params.dig(:filter, :category_ids)
  end

  private

    def safe_params
      @params.permit(:q, filter: { category_ids: [] })
      # @params.fetch(:filter, ActionController::Parameters.new).permit(category_ids: [])
    end
end
