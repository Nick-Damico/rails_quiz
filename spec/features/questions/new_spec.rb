require "rails_helper"

RSpec.describe "Author Adds New Question", type: :feature do
  let(:author) { create(:user) }
  let(:quiz) { create(:quiz) }

  before do
    sign_in author
  end

  scenario "Author navigates to new Question form" do
    visit quiz_path(quiz, author_id: author)
    click_link "Add Question"

    expect(page).to have_content("Create Question")
  end

  scenario "Author successfully creates a question" do
    question_attributes = attributes_for(:question, author:)
    visit quiz_path(quiz, author_id: author)
    click_link "Add Question"

    fill_in "Question Text", with: question_attributes[:content]
    click_button "Create Question"

    expect(page).to have_content(I18n.t("flash.questions.create.success"))
    expect(page).to have_content(question_attributes[:content])
  end

  scenario "Author fails to create a question due to invalid input" do
    visit quiz_path(quiz, author_id: author)
    click_link "Add Question"

    fill_in "Question Text", with: ""
    click_button "Create Question"

    expect(page).to have_content(I18n.t("flash.questions.create.error"))
  end
end
