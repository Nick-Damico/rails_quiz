require 'rails_helper'

RSpec.describe NewsPost, type: :model do
  let(:path) { Rails.root.join("spec", "fixtures") }
  let(:file_path) { path.join("example_news_post_1.md") }

  describe ".initialize" do
    it "accepts a file path" do
      expect { NewsPost.new(file_path) }.not_to raise_error
    end

    it "defines attributes slug, title, date, and content" do
      news_post = NewsPost.new(file_path)

      expect(news_post.slug).to eq("2026-august-updates")
      expect(news_post.title).to eq("2026 August Updates")
      expect(news_post.date).to eq("08-13-2026")
      expect(news_post.content).to include("August 2026 Update")
    end
  end

  describe ".all" do
    it "returns an array of NewsPost instances" do
      expect(NewsPost.all(path: path)).to all(be_a(NewsPost))
      expect(NewsPost.all(path: path).length).to eq(2)
    end
  end

  describe ".find_by_slug" do
    it "returns an instance of NewsPost" do
      expected_slug = "2026-august-updates"
      expect(NewsPost.find_by_slug(expected_slug, path: path)).to be_a(NewsPost)
      expect(NewsPost.find_by_slug(expected_slug, path: path).slug).to eq(expected_slug)
    end

    it "returns nil if no matching slug is found" do
      expect(NewsPost.find_by_slug("invalid-slug", path: path)).to be_nil
    end
  end
end
