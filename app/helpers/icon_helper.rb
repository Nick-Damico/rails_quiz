module IconHelper
  def render_icon(partial_name, options = {})
    icon_class = options[:klass] ? "#{options[:klass]}" : "size-6"

    @render_icon ||= {}
    @render_icon[partial_name.to_sym] ||= render("icons/#{partial_name}", klass: icon_class)
  end
end
