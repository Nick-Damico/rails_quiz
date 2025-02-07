require "rails_helper"

RSpec.describe "Author Previews Quiz Question", type: :feature do
  let(:author) { create(:user) }
  let!(:quiz) { create(:quiz, :with_questions, author:) }

  before do
    sign_in author
  end

  scenario "Author Previews Question" do
    visit author_quiz_path(quiz)

    selected_question = quiz.questions.first
    click_link "view", href: quiz_question_path(quiz, selected_question)

    expect(page).to have_content(selected_question.content)
  end
end
