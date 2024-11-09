module ApplicationHelper
  def back_button(path:, text: nil)
    btn_text = text || t("buttons.back")

    link_to btn_text, path, class: "inline-flex bg-primary text-white px-2 py-2 mb-4"
  end
end
