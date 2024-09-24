RSpec.describe 'Home Page', type: :feature do
  describe 'Get /index' do
    it 'displays the home page content' do
      visit root_path

      expect(page).to have_content('Welcome to QuizIt!')
    end
  end
end
