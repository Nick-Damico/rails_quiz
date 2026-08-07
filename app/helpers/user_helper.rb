module UserHelper
  def display_rank(user)
    return "No Rank" unless user.rank

    user.rank.titleize
  end

  def public_profile_tab_classes(active_tab, current_tab)
    base_styles = "inline-block p-4 border-b-2 rounded-t-lg"

    if active_tab == current_tab
      "#{base_styles} text-blue-600 border-blue-600"
    else
      "#{base_styles} border-transparent text-gray-500 hover:text-gray-600 hover:border-gray-300"
    end
  end
end
