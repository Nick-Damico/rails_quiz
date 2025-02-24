module ApplicationHelper
  def banner_heading(&block)
    content_tag(:header, class: "border border-gray-700 p-4") do
      yield if block_given?
    end
  end
end
