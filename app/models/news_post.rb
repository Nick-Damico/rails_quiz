require "commonmarker"
require "front_matter_parser"

class NewsPost
  PATH = Rails.root.join("app", "content", "news").freeze
  COMMON_MARKER_OPTIONS = {
    extension: {
      front_matter_delimiter: "---"
    }
  }

  attr_reader :slug, :title, :date, :content

  def initialize(file_path)
    raise "FileNotFoundError: #{file_path}" unless File.exist?(file_path)

    parsed_file   = parse_file(file_path)
    front_matter  = parsed_file.front_matter
    @title        = front_matter["title"]
    @date         = Date.parse(front_matter["date"])
    @content      = parsed_file.content
    @slug         = front_matter["title"].parameterize
  end

  def self.all(path: PATH)
    all_files(path:).map { |file_path| new(file_path) }
  end

  def self.find_by_slug(slug, path: PATH)
    all(path:).find { |news_post| news_post.slug == slug }
  end

  def self.sort_by_date(path: PATH)
    all(path:).sort_by(&:date).reverse
  end

  def to_param
    slug
  end

  def to_html
    Commonmarker.to_html(content, options: COMMON_MARKER_OPTIONS)
  end

  private

    def self.all_files(path: PATH)
      Dir.glob(path.join("*.md"))
    end

    def self.parse_file(file)
      ::FrontMatterParser::Parser.parse_file(file)
    end

    def parse_file(file)
      ::FrontMatterParser::Parser.parse_file(file)
    end
end
