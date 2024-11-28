require "rails_helper"

RSpec.describe "Author Deletes Question", type: feature do
  let(:author) { create(:user) }
  let!(:quiz) { create(:quiz, :with_questions) }

  before do
    sign_in author
  end

  scenario "Author Deletes Quiz Question" do
    selected_question = quiz.questions.first
    visit quiz_path(quiz, author_id: author)


    expect(page).to have_link('Destroy', href: quiz_question_path(quiz, selected_question))
  end
end
