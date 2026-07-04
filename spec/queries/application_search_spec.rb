require "rails_helper"

RSpec.describe ApplicationSearch, type: :model do
  describe "#query" do
    it "returns an ActiveRecord::Relation object" do
      params = ActionController::Parameters.new({ filter: { category_ids: [ 1, 2 ] } })
      search = ApplicationSearch.new(Deck.all, params) 

      expect(search.query).to be_a(ActiveRecord::Relation)
    end
  end

  describe "#params" do
    let!(:params) { ActionController::Parameters.new({
        filter: {
          category_ids: [ "1", "2" ],
          unpermitted_id: 1
        },
        outside_value: "foo"
      })
    }
    let!(:search) { ApplicationSearch.new(Deck.all, params) }

    it "returns permitted filter parameters" do
      expect(search.params).to be_permitted
    end

    it "does not include unpermitted filter parameters " do
      expect(search.params).not_to have_key("unpermitted_id")
    end

    it "does not include values outside of the required :filter hash" do
      expect(search.params).not_to have_key("outside_value")
    end
  end
end
