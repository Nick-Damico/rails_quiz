module ApplicationHelper
  def banner_heading(&block)
    content_tag(:div, class: "bg-gray-500 p-4") do
      yield if block_given?
    end
  end
end
