require "rails_helper"

RSpec.describe "Author Edits Quiz", type: :feature do
  let(:author) { create(:user) }

  before do
    sign_in author
  end

  scenario "Quiz is successfully updated with valid input" do
    quiz = create(:quiz, author:)

    visit edit_author_quiz_path(quiz)

    new_title = Faker::Book.title
    fill_in "Title", with: new_title
    click_button "Update Quiz"

    expect(page).to have_content(I18n.t("flash.quizzes.update.success"))
    expect(page).to have_content(new_title)
  end

  scenario "Quiz fails to update with invalid input" do
    quiz = create(:quiz, author: author)

    visit edit_author_quiz_path(quiz)

    fill_in "Title", with: ""
    click_button "Update Quiz"

    expect(page).to have_content(I18n.t("flash.quizzes.update.error"))
  end
end
