require "commonmarker"

class NewsPost
  PATH = Rails.root.join("app", "content", "news").freeze
  COMMON_MARKER_OPTIONS = {
    extension: {
      front_matter_delimiter: "---"
    }
  }

  attr_reader :slug, :title, :date, :content

  def initialize(front_matter, content)
    @slug = front_matter["title"].parameterize
    @title = front_matter["title"]
    @date = front_matter["date"]
    @content = content
  end

  def self.all
    all_files.map do |file|
      parsed_file = self.parse_file(file)
      new(parsed_file.front_matter, parsed_file.content)
    end
  end

  def self.find_by_slug(slug)
    all.find { |news_post| news_post.slug == slug }
  end

  def self.parse_file(file)
    ::FrontMatterParser::Parser.parse_file(file)
  end

  def self.most_recent
    return nil unless (file = recent_file)

    parsed_file = parse_file(file)
    new(parsed_file.front_matter, parsed_file.content)
  end

  def to_param
    slug
  end

  def to_html
    Commonmarker.to_html(content, options: COMMON_MARKER_OPTIONS)
  end

  private

    def self.recent_file
      files = Dir.glob(PATH.join("*.md"))
      return nil unless files.any?

      files.first
    end

    def self.all_files
      Dir.glob(PATH.join("*.md"))
    end
end
