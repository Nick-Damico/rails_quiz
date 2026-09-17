require "rails_helper"

RSpec.describe Admin::DecksController, type: :request do
  let(:admin) { create(:user, :with_admin) }
  let(:user) { create(:user) }
  let(:deck) { create(:deck, author: user) }

  describe "GET /admin/decks/:id/edit" do
    context "when not authenticated" do
      before { sign_in user }

      it "redirects to root url with an access denied message" do
        get edit_admin_deck_path(create(:deck))

        expect(response).to redirect_to(root_url)
        expect(flash[:alert]).to eq("Access denied.")
      end
    end

    context "when authenticated as admin" do
      before do
        sign_in admin
      end

      it "responds successfully" do
        get edit_admin_deck_path(deck)

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PATCH /admin/decks/:id" do
    context "when not authenticated" do
      before { sign_in user }

      it "redirects to root url with an access denied message" do
        get edit_admin_deck_path(create(:deck))

        expect(response).to redirect_to(root_url)
        expect(flash[:alert]).to eq("Access denied.")
      end
    end

    context "when authenticated as admin" do
      before do
        sign_in admin
      end

      context "with valid params" do
        it "redirects to admin dashboard" do
          patch admin_deck_path(deck), params: { deck: { title: "101 computer science" } }

          expect(response).to redirect_to(admin_dashboard_url(tab: "deck"))
        end

        it "updates the information" do
          patch admin_deck_path(deck), params: { deck: { title: "101 computer science", description: "learn fundamentals" } }

          deck.reload
          expect(deck.title).to eq("101 computer science")
          expect(deck.description).to eq("learn fundamentals")
        end

        context "when deactivating a quiz" do
          it "sets the deck to hidden & unpublishes it" do
            deck = create(:deck, :published)
            patch admin_deck_path(deck), params: { deck: { hidden: "1" } }

            deck.reload
            expect(deck).to be_hidden
            expect(deck).not_to be_published
          end
        end
      end

      context "with invalid params" do
        it "responds with status code of unprocessable content" do
          patch admin_deck_path(deck), params: { deck: { title: "" } }

          expect(response).to have_http_status(:unprocessable_content)
        end

        it "does not update the deck information" do
          original_title = deck.title

          patch admin_deck_path(deck), params: { deck: { title: "" } }

          expect(deck.reload.title).to eq(original_title)
        end
      end
    end
  end
end
