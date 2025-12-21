module BreadcrumbHelper
  ## Renders a breadcrumb item.
  ## If it's the last item, it won't be a link and won't have an > icon .

  ## TODO: last_item should text only not a link.
  def breadcrumb_item(breadcrumb, last_item: false)
    content = build_content(breadcrumb, last_item)

    if breadcrumb.path && !last_item
      link_to(content, breadcrumb.path, title: breadcrumb.name, class: "px-1 py-2 flex items-center underline group")
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
      @icon ||= render_icon("chevron_right", klass: "size-4 ml-1")
    end
end
