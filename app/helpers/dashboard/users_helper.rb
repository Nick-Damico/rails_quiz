module Dashboard::UsersHelper
  def avatar(user)
    return unless user

    if user.avatar.present?
      image_tag current_user.avatar, class: "w-8 h-8 rounded-full border-2 border-gray-500 hover:border-emerald-500 transition-border ease-in-out duration-500"
    else
      content_tag :div, class: "w-8 h-8 rounded-full bg-emerald-400"
    end
  end
end
