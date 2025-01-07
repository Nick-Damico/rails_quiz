require "rails_helper"

RSpec.describe "Author Adds New Quiz", type: :feature do
  let(:author) { create(:user) }

  before do
    sign_in author
  end

  scenario "Author creates a new quiz successfully" do
    quiz_attributes = attributes_for(:quiz, author: author)
    visit new_author_quiz_path

    fill_in "Title", with: quiz_attributes[:title]
    fill_in "Description", with: quiz_attributes[:description]
    click_button "Create Quiz"

    expect(page).to have_content(I18n.t("flash.quizzes.create.success"))
    expect(page).to have_content(quiz_attributes[:title])
  end

  scenario "Author fails to create Quiz with invalid input" do
    quiz_attributes = attributes_for(:quiz, author: author)
    visit new_author_quiz_path

    fill_in "Title", with: ""
    fill_in "Description", with: quiz_attributes[:description]
    click_button "Create Quiz"

    expect(page).to have_content(I18n.t("flash.quizzes.create.error"))
    expect(page).to have_content("Can't be blank")
  end
end
