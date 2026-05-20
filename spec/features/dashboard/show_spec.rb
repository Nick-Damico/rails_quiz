require 'rails_helper'

RSpec.describe 'Dashboard Show View', type: :feature do
  scenario 'User views rank' do
    user = create(:user)
    sign_in user
    user.update_column(:rank, :study_warrior)

    visit dashboard_user_path(user)

    expect(page).to have_content('Study Warrior')
  end
end
