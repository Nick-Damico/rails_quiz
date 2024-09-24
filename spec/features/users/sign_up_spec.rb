require 'rails_helper'

RSpec.describe 'User Authentication Forms', type: :feature do
  scenario 'User creates an account' do
      random_password = Faker::Internet.password(min_length: 6, max_length: 6, mix_case: true, special_characters: true)
      email = Faker::Internet.email

      visit new_user_registration_path

      fill_in 'Email', with: email
      fill_in 'Password', with: random_password
      fill_in 'Password Confirmation', with: random_password

      click_button 'Sign Up'

      expect(page).to have_content("Hello #{email}")
  end

  scenario 'User logs in' do
    random_password = Faker::Internet.password(min_length: 6, max_length: 6, mix_case: true, special_characters: true)
    user = create(:user, password: random_password, password_confirmation: random_password)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: random_password

    click_button 'Log in'

    expect(page).to have_content("Hello #{user.email}")
  end
end
