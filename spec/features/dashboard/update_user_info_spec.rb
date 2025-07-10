require 'rails_helper'

RSpec.describe 'Dashboard User Updates Information', type: :feature do
  scenario 'User changes username' do
    user = create(:user)
    sign_in user
    new_username = Faker::Name.unique

    visit dashboard_user_path(user)

    fill_in 'Username', with: new_username
    within('#general_info_form') do
      click_button 'Update User'
    end
  end
end
