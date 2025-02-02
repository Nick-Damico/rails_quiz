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

    context "without questions" do
      scenario "author sees 'No Questions' message" do
        expect(page).to have_content('No Questions')
      end
    end

    context "with questions" do
      let!(:quiz) { create(:quiz, author:, questions_count: 2) }
      scenario "author should not see 'No Questions' message" do
        expect(page).to_not have_content('No Questions')
      end
    end
  end
end
