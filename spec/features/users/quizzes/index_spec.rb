require "rails_helper"

RSpec.describe "user quizzes index page", type: :feature do
  let(:user) { create(:user) }

  context "with quizzes" do
    let!(:quiz) { create(:quiz) }

    before do
      sign_in user

      visit root_url
      click_link "Study"
    end

    scenario "user can navigate to quizzes page" do
      expect(page).to have_content("Community Quizzes")
      expect(page).to have_content(quiz.title)
    end

    scenario "user can access show page for a quiz via link" do
      expect(page).to have_link("view", href: quiz_path(quiz))
    end

    scenario "user can navigate quiz show page" do
      click_link "view", href: quiz_path(quiz)

      expect(current_path).to eq(quiz_path(quiz))
      expect(page).to have_content(quiz.title)
    end
  end
end
