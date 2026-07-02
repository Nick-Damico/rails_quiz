module FilterHelper
  def filter_selected?(option, key)
    params.dig(:filter, key.to_sym)&.include?(option.to_s)
  end
end
