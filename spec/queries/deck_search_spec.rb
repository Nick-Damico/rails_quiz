require "rails_helper"

RSpec.describe DeckSearch, type: :model do
  let(:category_arts) { create(:category, name: "Arts") }
  let(:category_cs) { create(:category, name: "Computer Science") }
  let!(:deck_1) {
    create(
      :deck,
      title: "Computer Science 101",
      description: "An introduction to programming.",
      category: category_cs
    )
  }
  let!(:deck_2) {
    create(
      :deck,
      title: "History of Art",
      description: "A study of famous artists.",
      category: category_arts
    )
  }
  describe "#query" do
    context "with text search" do
      it "matches on title" do
        params = ActionController::Parameters.new({ q: "History" })
        search = DeckSearch.new(Deck.all, params)

        expect(search.query).to contain_exactly(deck_2)
      end
      it "matches on description" do
        params = ActionController::Parameters.new({ q: "programming" })
        search = DeckSearch.new(Deck.all, params)

        expect(search.query).to contain_exactly(deck_1)
      end

      it "matches on category" do
        params = ActionController::Parameters.new({ q: "Arts" })
        search = DeckSearch.new(Deck.all, params)

        expect(search.query).to contain_exactly(deck_2)
      end
    end

    context "with category filters" do
      it "matches on category" do
        params = ActionController::Parameters.new({ filter: { category_ids: [ deck_1.category.id ] } })
        search = DeckSearch.new(Deck.all, params)

        expect(search.query).to contain_exactly(deck_1)
      end
    end
  end
end
