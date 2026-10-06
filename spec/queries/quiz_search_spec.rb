require "rails_helper"

RSpec.describe QuizSearch, type: :model do
  let!(:quiz_1) {
    create(
      :quiz,
      title: "Computer Science 101",
      description: "An introduction to programming.",
      category: create(:category, name: "Computer Science")
    )
  }
  let!(:quiz_2) {
    create(
      :quiz,
      title: "History of Art",
      description: "A study of famous artists.",
      category: create(:category, name: "Arts")
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
    end
  end
end
