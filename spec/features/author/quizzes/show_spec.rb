require "rails_helper"

RSpec.describe "Author Edits Quiz", type: :feature do
  let(:author) { create(:user) }

  before do
    sign_in author
  end

  context "with quiz" do
    let!(:quiz) { create(:quiz, author:, questions_count: 0) }

    before do
      visit author_quiz_path(quiz)
    end

    scenario "author can see quiz details" do
      expect(page).to have_content(quiz.title)
      expect(page).to have_content(quiz.author.username)
      expect(page).to have_content(quiz.description)
    end

    context "without description" do
      scenario "author sees no description message" do
        quiz.update(description: nil)

        visit author_quiz_path(quiz)

        expect(page).to have_content("No description available")
      end
    end


    context "without questions" do
      scenario "author sees no questions message" do
        expect(page).to have_content('No questions available')
      end
    end
  end
end
