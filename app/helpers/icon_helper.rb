module IconHelper
  def render_icon(partial_name, options = {})
    @render_map ||= {}
    icon_class = options[:klass] || "size-6"
    data_attrs = options[:data] || {}
    cached = @render_map[partial_name.to_sym]

    if cached.nil? || (cached[:klass] != icon_class || cached[:data] != data_attrs)
      @render_map[partial_name.to_sym] = {
        klass: icon_class,
        html: render(
          "icons/#{partial_name}",
          klass: icon_class,
          data: data_attrs
        )
      }
    end

    @render_map[partial_name.to_sym][:html]
  end
end
