require "rails_helper"

RSpec.describe "Author Edits Question", type: :feature do
  let(:author) { create(:user) }
  let!(:quiz) { create(:quiz, :with_questions, author:) }

  before do
    sign_in author
  end

  scenario "Author Navigates to Question Edit Form" do
    selected_question = quiz.questions.first
    visit quiz_question_path(quiz, selected_question)

    click_link '', href: edit_quiz_question_path(quiz, selected_question)

    expect(page).to have_content("Edit Question")
  end

  scenario "Author successfully creates a question" do
    selected_question = quiz.questions.first
    new_question_text = Faker::Lorem.sentence
    visit quiz_question_path(quiz, selected_question)
    click_link '', href: edit_quiz_question_path(quiz, selected_question)

    fill_in "Question Text", with: new_question_text
    click_button "Update Question"

    expect(page).to have_content(I18n.t("flash.questions.update.success"))
    expect(page).to have_content(new_question_text)
  end

  scenario "Error prevents Author from editing question" do
    selected_question = quiz.questions.first
    invalid_question_text = ''
    visit quiz_question_path(quiz, selected_question)
    click_link '', href: edit_quiz_question_path(quiz, selected_question)

    fill_in "Question Text", with: invalid_question_text
    click_button "Update Question"

    expect(page).to have_content(I18n.t("flash.questions.update.error"))
  end

  context "Question Choices" do
    scenario "Add Choice button is available" do
      selected_question = quiz.questions.first

      visit edit_quiz_question_path(quiz, selected_question)

      expect(page).to have_selector(:link_or_button, 'Add')
    end
  end
end
