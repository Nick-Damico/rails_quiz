require 'rails_helper'

RSpec.describe 'Authored Quizzes', type: :feature do
  scenario 'Author Creates a Quiz' do
      author = create(:user)
      sign_in author

      visit new_quiz_path(author_id: author)

    # fill_in 'Email', with: email
    # fill_in 'Username', with: username
    # fill_in 'Password', with: random_password
    # fill_in 'Password Confirmation', with: random_password

    # click_button 'Sign Up'

    # expect(page).to have_content("Hello #{username}")
  end
end
