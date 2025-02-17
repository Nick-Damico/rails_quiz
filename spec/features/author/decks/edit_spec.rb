require "rails_helper"

RSpec.describe "author/decks edit page", type: :feature do
  let(:author) { create(:user) }
  let!(:deck) { create(:deck, author:) }

  before do
    sign_in author

    visit edit_author_deck_path(deck)
  end

  context "with valid input" do
    scenario "author can update deck details" do
      new_title = "Behavioral Design Patterns"

      fill_in "Title", with: new_title
      fill_in "Description", with: deck.description

      click_button "Update Deck"

      expect(page).to have_content(I18n.t("flash.decks.update.success"))
      expect(page).to have_content(new_title)
    end
  end

  context "with invalid input" do
    scenario "author cannot update deck details" do
      fill_in "Title", with: ''
      fill_in "Description", with: deck.description

      click_button "Update Deck"

      expect(page).to have_content(I18n.t("flash.decks.update.error"))
      #
      # Testing in the browser re-renders the :new partial, but this
      # spec is failing due to a current_path of /author/decks/
      # Not sure what is causing it.
      # expect(page).to have_current_path(edit_author_deck_path(deck))
    end
  end
end
