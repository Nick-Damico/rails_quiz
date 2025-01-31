module BreadcrumbHelper
  def breadcrumb_item(breadcrumb, last_item: false)
    content = build_content(breadcrumb, last_item)

    if breadcrumb.path
      link_to(content, breadcrumb.path, class: "px-1 py-2 flex items-center underline group")
    else
      content_tag(:span, content, class: "px-1 py-2 flex items-center")
    end
  end

  private

  def build_content(breadcrumb, last_item)
    if last_item
      breadcrumb.name.truncate(20)
    else
      safe_join([ breadcrumb.name.truncate(20), content_tag(:span, icon) ])
    end
  end

  def icon
    @icon ||= render partial: "icons/chevron_right", locals: { klass: "size-4 ml-1" }
  end
end
