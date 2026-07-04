class ApplicationSearch
  attr_reader :scope

  def initialize(scope, params)
    @scope = scope
    @params = params
  end

  def params
    safe_params
  end

  def query
    scope
  end

  private

    def safe_params
      @params.require(:filter).permit(:outside_value, category_ids: [])
    end
end
