require "rails_helper"

RSpec.describe "User authors a Quiz", type: :feature do
  let(:author) { create(:user) }
  let(:quiz_attributes) { attributes_for(:quiz, author: author) }

  before do
    sign_in author
  end

  scenario "User creates a new quiz successfully" do
    visit new_author_quiz_path(author)

    fill_in "Name", with: quiz_attributes[:name]
    fill_in "Description", with: quiz_attributes[:description]
    choose "Multiple Choice" # Assuming you have different quiz types

    # Add questions and answers
    fill_in "Question 1", with: "What is 2+2?"
    fill_in "Answer 1", with: "4"

    click_button "Create Quiz"

    # Expectations
    expect(page).to have_content("Quiz was successfully created.")
    expect(page).to have_content(quiz_attributes[:title])
  end
end
