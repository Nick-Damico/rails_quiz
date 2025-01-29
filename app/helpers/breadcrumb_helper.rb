module BreadcrumbHelper
  def breadcrumb_item(breadcrumb)
    content = build_content(breadcrumb)

    if breadcrumb.path
      link_to(content, breadcrumb.path, class: "px-1 py-2 flex items-center underline group")
    else
      content_tag(:span, content, class: "px-1 py-2 flex items-center")
    end
  end

  private

  def build_content(breadcrumb)
    if current_page?(breadcrumb.path)
      breadcrumb.name.truncate(20)
    else
      safe_join([ breadcrumb.name.truncate(20), content_tag(:span, icon) ])
    end
  end

  def icon
    @icon ||= render partial: "icons/chevron_right", locals: { klass: "size-4 ml-1" }
  end
end
