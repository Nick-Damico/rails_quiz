require "rails_helper"

RSpec.describe "Author Adds New Question", type: :feature do
  let(:author) { create(:user) }
  let!(:quiz) { create(:quiz, :with_questions) }

  before do
    sign_in author
  end

  scenario "Author Previews Question" do
    visit quiz_path(quiz, author_id: author)

    selected_question = quiz.questions.first
    click_link "view", href: quiz_question_path(quiz, selected_question)

    expect(page).to have_content(selected_question.content)
  end
end
