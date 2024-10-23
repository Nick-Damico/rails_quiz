require "rails_helper"

RSpec.describe "User authors a Quiz", type: :feature do
  let(:author) { create(:user) }

  before do
    sign_in author
  end

  scenario "User creates a new quiz successfully" do
    quiz_attributes = attributes_for(:quiz, author: author)
    visit new_author_quiz_path(author)

    fill_in "Title", with: quiz_attributes[:title]
    fill_in "Description", with: quiz_attributes[:description]
    click_button "Create Quiz"

    expect(page).to have_content("Quiz was successfully created.")
    expect(page).to have_content(quiz_attributes[:title])
  end
end
