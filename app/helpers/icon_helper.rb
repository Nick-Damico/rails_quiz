module IconHelper
  def render_icon(partial_name, options = {})
    icon_class = options[:klass] || "size-6"
    @render_map ||= {}

    cached = @render_map[partial_name.to_sym]

    if cached.nil? || cached[:klass] != icon_class
      @render_map[partial_name.to_sym] = {
        klass: icon_class,
        html: render("icons/#{partial_name}", klass: icon_class)
      }
    end

    @render_map[partial_name.to_sym][:html]
  end
end
