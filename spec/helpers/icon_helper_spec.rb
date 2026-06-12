require "rails_helper"

RSpec.describe IconHelper, type: :helper do
  describe "#render_icon" do
    let(:partial_name) { "plus" }
    let(:options) { { klass: "size-8", data: { test: "true" } } }

    it "renders the HTML icon with the specified options" do
      html = helper.render_icon(partial_name, options)

      expect(html).to include("size-8")
      expect(html).to include("data-test=\"true\"")
    end

    context "caching" do
      it "caches the rendered icon" do
        helper.render_icon(partial_name, options)

        expect(helper.instance_variable_get(:@render_map)).to have_key(partial_name.to_sym)
      end

      it "returns cached HTML for the same icon and options" do
        expect(helper).to receive(:render).once

        helper.render_icon(partial_name, options) # First call
        helper.render_icon(partial_name, options) # Seocnd call
      end
    end
  end
end
