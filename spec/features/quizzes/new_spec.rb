require "rails_helper"

RSpec.describe "Author Adds New Quiz", type: :feature do
  let(:author) { create(:user) }

  before do
    sign_in author
  end

  scenario "Author creates a new quiz successfully" do
    quiz_attributes = attributes_for(:quiz, author: author)
    visit new_quiz_path(author_id: author)

    fill_in "Title", with: quiz_attributes[:title]
    fill_in "Description", with: quiz_attributes[:description]
    click_button "Create Quiz"

    expect(page).to have_content(I18n.t("flash.quizzes.create.success"))
    expect(page).to have_content(quiz_attributes[:title])
  end

  scenario "Author edits Quiz" do
    quiz = create(:quiz, author: author)
    new_quiz_title = "Updated Quiz"

    visit edit_quiz_path(quiz, author_id: author)
    fill_in "Title", with: new_quiz_title
    click_button "Update Quiz"

    expect(page).to have_content(I18n.t("flash.quizzes.update.success"))
    expect(page).to have_content(new_quiz_title)
  end
end
