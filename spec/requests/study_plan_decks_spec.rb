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

  describe "DELETE /study_plan_deck/:id" do
    context "successfully removing a deck from the study plan" do
      let!(:study_plan_deck) { create(:study_plan_deck, study_plan: study_plan, deck: deck) }

      subject(:delete_study_plan_deck) do
        delete study_plan_deck_path(study_plan_deck)
      end

      it "removes the deck from the study plan" do
        expect { delete_study_plan_deck }.to change(StudyPlanDeck, :count).by(-1)
      end

      it "renders a success flash message" do
        delete_study_plan_deck

        expect(flash[:notice]).to eq(
          "Deck was successfully removed from your study plan."
        )
      end
    end

    context "when the deck cannot be removed" do
      let!(:study_plan_deck) { create(:study_plan_deck, study_plan:, deck:) }

      before do
        allow_any_instance_of(StudyPlanDeck).to receive(:destroy).and_return(false)
      end

      it "does not remove the deck" do
        expect { delete study_plan_deck_path(study_plan_deck) }
          .not_to change(StudyPlanDeck, :count)
      end

      it "shows an error message" do
        delete study_plan_deck_path(study_plan_deck)

        expect(flash[:alert]).to eq(
          "Unable to remove deck from study plan. Refresh page and try again."
        )
      end
    end
  end
end
