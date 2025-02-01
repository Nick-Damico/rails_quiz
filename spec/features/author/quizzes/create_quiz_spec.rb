require 'rails_helper'

RSpec.describe 'Authored Quizzes', type: :feature do
  let!(:author) { create(:user) }

  before do
    sign_in author
  end

  scenario 'Author Creates a Quiz' do
    visit author_quizzes_path(author)

    click_link "Create Quiz"

    quiz_attributes = attributes_for(:quiz)
    fill_in 'Title', with: quiz_attributes[:title]
    fill_in 'Description', with: quiz_attributes[:description]

    click_button 'Create Quiz'

    expect(page).to have_content(I18n.t("flash.quizzes.create.success"))
    expect(page).to have_content(quiz_attributes[:title])
    expect(page).to have_content(quiz_attributes[:description])
    expect(page).to have_current_path(author_quiz_url(Quiz.last))
  end


  scenario 'Author fails to Create a Quiz' do
    visit author_quizzes_path(author)

    click_link "Create Quiz"
    fill_in 'Title', with: ''
    click_button 'Create Quiz'

    expect(page).to have_content(I18n.t("flash.quizzes.create.error"))
  end
end
