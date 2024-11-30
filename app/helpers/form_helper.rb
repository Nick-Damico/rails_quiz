module FormHelper
  def fields_with_error_icon(model, field)
    return if model.errors[field.to_sym].none?

    render "icons/exclamation_triangle"
  end

  def display_field_with_error(model, field)
    field_sym = field.to_sym
    return unless model.errors[field_sym].present?

    content_tag(:p, class: "flex items-center text-sm text-red-400 mt-1") do
      concat fields_with_error_icon(model, field_sym)
      concat model.errors[field_sym].join(", ")
    end
  end
end
