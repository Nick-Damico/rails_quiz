require "rails_helper"

RSpec.describe "author/decks index page", type: :feature do
  let(:author) { create(:user) }

  context "with decks" do
    let!(:decks) { create_list(:deck, 2, author:) }

    before do
      sign_in author

      visit author_decks_url
    end

    scenario "author can see list of their decks" do
      decks.pluck(:title).each do |title|
        expect(page).to have_content(title)
      end
    end

    scenario "author can navigate deck show page via link" do
      deck = decks.first

      click_link "view", href: author_deck_path(deck)

      expect(current_path).to eq(author_deck_path(deck))
    end

    scenario "author can access 'Create Deck' button" do
      expect(page).to have_link("Create Deck", href: new_author_deck_path)
    end
  end
end
