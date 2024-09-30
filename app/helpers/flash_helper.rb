module FlashHelper
  def flash_class(level)
      case level
      when "notice" then "bg-green-100 text-green-800 border-green-300"
      when "alert", "error" then "bg-red-100 text-red-800 border-red-300"
      else "bg-blue-100 text-blue-800 border-blue-300"
      end
  end

  def flash_button_class(level)
    case level
    when "notice" then "bg-green-500"
    when "alert", "error" then "bg-red-500"
    else "bg-blue-500"
    end
  end
end
