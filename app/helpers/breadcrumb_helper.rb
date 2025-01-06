module BreadcrumbHelper
  def breadcrumb_item(breadcrumb)
    icon = render partial: "icons/chevron_right",
                  locals: { klass: "size-4 ml-1" }
    content = safe_join([ breadcrumb.name, content_tag(:span, icon) ])

    link_to(content, breadcrumb.path, class: "px-1 py-2 flex items-center hover:underline group")
  end
end
