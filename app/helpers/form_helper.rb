module FormHelper
  def display_field_error(model, field)
    field_sym = field.to_sym
    return unless model.errors[field_sym].present?

    safe_join(model.errors[field].map do |error|
      field_with_error_msg(error)
    end)
  end

  private

  def field_with_error_msg(error)
    content_tag(:p, class: "flex items-center text-xs text-red-400 mt-1") do
      concat field_with_error_icon
      concat error.capitalize
    end
  end

  def field_with_error_icon
    render "icons/exclamation_triangle"
  end
end
