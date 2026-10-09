require "rails_helper"

RSpec.describe QuizSearch, type: :model do
  let(:category_arts) { create(:category, name: "Arts") }
  let(:category_cs) { create(:category, name: "Computer Science") }
  let!(:quiz_1) {
    create(
      :quiz,
      title: "Computer Science 101",
      description: "An introduction to programming.",
      category: category_cs
    )
  }
  let!(:quiz_2) {
    create(
      :quiz,
      title: "History of Art",
      description: "A study of famous artists.",
      category: category_arts
    )
  }
  describe "#query" do
    context "with text search" do
      it "matches on title" do
        params = ActionController::Parameters.new({ q: "History" })
        search = QuizSearch.new(Quiz.all, params)

        expect(search.query).to contain_exactly(quiz_2)
      end
      it "matches on description" do
        params = ActionController::Parameters.new({ q: "programming" })
        search = QuizSearch.new(Quiz.all, params)

        expect(search.query).to contain_exactly(quiz_1)
      end

      it "matches on category" do
        params = ActionController::Parameters.new({ q: "Arts" })
        search = QuizSearch.new(Quiz.all, params)

        expect(search.query).to contain_exactly(quiz_2)
      end
    end

    context "with category filters" do
      it "matches on category" do
        params = ActionController::Parameters.new({ filter: { category_ids: [ quiz_1.category.id ] } })
        search = QuizSearch.new(Quiz.all, params)

        expect(search.query).to contain_exactly(quiz_1)
      end
    end
  end
end
