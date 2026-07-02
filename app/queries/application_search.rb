class ApplicationSearch
  attr_reader :scope

  def initialize(scope, params)
    @scope = scope
    @params = params
  end

  def params
    safe_params
  end

  private

    def safe_params
      @params.fetch(:filter, {}).permit(category_ids: [])
    end
end
