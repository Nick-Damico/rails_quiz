require "rails_helper"

RSpec.describe ApplicationSearch, type: :model do
  describe "#initialize" do
    it 'requires an instance of ActionController::Parameters' do
       expect { ApplicationSearch.new(Deck.all, {}) }.to raise_error
     end
  end

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
      expect(search.params).to have_key("category_ids")
    end

    it "does not raise_error if :filter key is missing from parameters" do
      params = ActionController::Parameters.new({ id: "1" })
      search = ApplicationSearch.new(Deck.all, params)

      expect { search.params }.not_to raise_error
    end
  end
end
