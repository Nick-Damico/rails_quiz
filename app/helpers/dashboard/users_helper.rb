module Dashboard::UsersHelper
  def avatar(user)
    return unless user

    if user.avatar.present?
      image_tag user.avatar, class: "w-8 h-8 rounded-full border-2 border-gray-500 hover:border-emerald-500 transition-border ease-in-out duration-500"
    else
      content_tag :div, "", class: "w-8 h-8 rounded-full bg-emerald-400"
    end
  end

  def avatar_path(user)
    if user == current_user
      dashboard_user_path(user)
    else
      public_profile_user_path(user)
    end
  end
end
