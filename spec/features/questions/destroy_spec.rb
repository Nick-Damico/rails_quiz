require "rails_helper"

RSpec.describe "Author Deletes Question", type: :feature do
  let(:author) { create(:user) }
  let!(:quiz) { create(:quiz, :with_questions) }

  before do
    sign_in author
  end

  scenario "Author locates delete button for question" do
    selected_question = quiz.questions.first
    visit author_quiz_path(quiz)

    expect(page).to have_content(selected_question.content)
    expect(page).to have_link("delete", href: quiz_question_path(quiz, selected_question))
  end

  scenario "Author removes question using delete button" do
    selected_question = quiz.questions.first
    visit author_quiz_path(quiz)

    click_link "delete", href: quiz_question_path(quiz, selected_question)

    expect(page).to_not have_content(selected_question.content)
    expect(page).to_not have_link("delete", href: quiz_question_path(quiz, selected_question))
  end
end
