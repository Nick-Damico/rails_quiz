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

  private

    def safe_params
      @params.fetch(:filter, ActionController::Parameters.new).permit(:outside_value, category_ids: [])
    end
end
