module ApplicationHelper
  def banner_heading(&block)
    content_tag(:header, class: "border border-gray-700 p-4") do
      yield if block_given?
    end
  end

  def tab_classes(active_tab, current_tab)
    base_styles = "inline-block p-4 border-b-2 rounded-t-lg"

    if active_tab.downcase == current_tab.downcase
      "#{base_styles} text-blue-600 border-blue-600"
    else
      "#{base_styles} border-transparent text-gray-500 hover:text-gray-600 hover:border-gray-300"
    end
  end
end
