# spec/requests/study_plan_decks_spec.rb
require "rails_helper"

RSpec.describe "StudyPlanDecks", type: :request do
  let(:user) { create(:user) }
  let(:study_plan) { create(:study_plan, user: user) }
  let(:deck) { create(:deck) }

  before do
    sign_in user
  end

  describe "POST /study_plan_decks" do
    subject(:create_study_plan_deck) do
      post study_plan_decks_path,
           params: { study_plan_deck: { study_plan_id: study_plan.id, deck_id: deck.id } }
    end

    context "when the deck is successfully added to the study plan" do
      it "creates a study plan deck association" do
        expect { create_study_plan_deck }
          .to change(StudyPlanDeck, :count).by(1)
      end

      it "redirects to the study plan show page" do
        create_study_plan_deck

        # expect(response).to render_template("users/study_plans/show")
        expect(response).to redirect_to(user_study_plan_path(user, study_plan))
      end

      it "sets a success flash message" do
        create_study_plan_deck

        expect(flash[:notice]).to eq("Deck was successfully added to your study plan.")
      end
    end

    context "when the deck is already in the study plan" do
      before do
        create(:study_plan_deck, study_plan: study_plan, deck: deck)
      end
      it "does not create another study plan deck association" do
        expect { create_study_plan_deck }
          .not_to change(StudyPlanDeck, :count)
      end

      it "redirects the deck show page" do
        create_study_plan_deck

        expect(response).to redirect_to deck_path(deck)
      end

      it "sets an error flash message" do
        create_study_plan_deck

        expect(flash[:alert]).to eq(
          "Deck already added to your study plan. Please select a different deck."
        )
      end
    end
  end
end
