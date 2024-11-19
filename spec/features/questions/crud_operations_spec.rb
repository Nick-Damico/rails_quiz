require "rails_helper"

RSpec.describe "CRUD Operations", type: :feature do
  let(:author) { create(:user) }
  let(:quiz) { create(:quiz) }

  before do
    sign_in author
  end

  scenario "Author successfully creates a question" do
    question_attributes = attributes_for(:question, author:)
    visit quiz_path(quiz, author_id: author.id)

    click_link "Add Question"

    fill_in "Content", with: question_attributes[:content]
    click_button "Create Question"

    expect(page).to have_content(I18n.t("flash.questions.create.success"))
    expect(page).to have_content(question_attributes[:content])
  end
end
