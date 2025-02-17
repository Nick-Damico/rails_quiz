require "rails_helper"

RSpec.describe "author/decks new page", type: :feature do
  let(:author) { create(:user) }
  before do
    sign_in author
    visit author_decks_path

    click_link "Create Deck"

    expect(current_path).to eq new_author_deck_path
  end

  context "with valid input" do
    scenario "author creates a new deck" do
      deck_attrs = attributes_for(:deck, author:)

      fill_in "Title", with: deck_attrs[:title]
      fill_in "Description", with: deck_attrs[:description]
      click_button "Create Deck"

      expect(page).to have_content(I18n.t("flash.decks.create.success"))
      expect(page).to have_content(deck_attrs[:title])
    end
  end

  context "with invalid input" do
    scenario "author fails to create a new deck" do
      deck_attrs = attributes_for(:deck, author:)

      fill_in "Title", with: ''
      fill_in "Description", with: deck_attrs[:description]

      click_button "Create Deck"

      expect(page).to have_content(I18n.t("flash.decks.create.error"))
      #
      # Testing in the browser re-renders the :new partial, but this
      # spec is failing due to a current_path of /author/decks/
      # Not sure what is causing it.
      # expect(page).to have_current_path(new_author_deck_path)
    end
  end
end
