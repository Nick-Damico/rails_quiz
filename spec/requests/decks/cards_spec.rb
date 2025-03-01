require 'rails_helper'

RSpec.describe "Decks::Cards", type: :request do
  let!(:author) { create(:user) }
  let!(:deck) { create(:deck, author:) }

  before { sign_in author }

  describe "GET /show" do
    it "responds with HTTP status ok(200)" do
      card = create(:card, deck:)
      get card_path(card)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /new" do
    it "responds with HTTP status ok(200)" do
      get new_deck_card_path(deck_id: deck.id)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context 'valid params' do
      let(:valid_params) { { card: { front: 'Name the 3 categories of design patterns', back: 'creational, structural, & behavioral', deck_id: deck.id } } }

      it "responds with HTTP status redirect(302)" do
        post deck_cards_path(deck_id: deck.id), params: valid_params

        expect(response).to redirect_to(new_deck_card_url(deck))
        expect(flash[:notice]).to eq("Flashcard was successfully created.")
      end

      it "creates flashcard record" do
        expect {
          post deck_cards_path(deck_id: deck.id), params: valid_params
        }.to change(Decks::Card, :count).by(1)
      end

      context "save & add another" do
        it "creates the card record and redirects to the new form" do
          valid_params.merge!(follow_up_action: 'new')

          expect {
            post deck_cards_path(deck_id: deck.id), params: valid_params
          }.to change(Decks::Card, :count).by(1)

          expect(response).to redirect_to new_deck_card_url(deck_id: deck.id)
          expect(flash[:notice]).to eq("Flashcard was successfully created.")
        end
      end

      context "save & return" do
        it "creates the card record and redirects to the deck show view" do
          valid_params.merge!(follow_up_action: 'show')

          expect {
            post deck_cards_path(deck_id: deck.id), params: valid_params
          }.to change(Decks::Card, :count).by(1)

          expect(response).to redirect_to author_deck_url(deck.id)
          expect(flash[:notice]).to eq("Flashcard was successfully created.")
        end
      end
    end
  end

  describe "GET /edit" do
    let!(:card) { create(:card, deck:) }

    it "responds with HTTP status ok(200)" do
      get edit_card_path(card)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT /update" do
    let!(:card) { create(:card, deck:) }

    context "with valid params" do
      let(:valid_params) do
        {
          card: {
            front: "What is Ruby on Rails?",
            back: "A web application framework written in Ruby",
            deck_id: deck.id
          }
        }
      end

      context "update & add another" do
        it "updates the card record and redirects to the new form" do
          valid_params.merge!(follow_up_action: 'new')

          expect {
            put card_path(card), params: valid_params
          }.to change(Decks::Card, :count).by(0)

          expect(response).to redirect_to new_deck_card_url(deck_id: deck.id)
          expect(flash[:notice]).to eq("Flashcard was successfully updated.")
        end
      end

      context "update & return" do
        it "updates the card record and redirects to the deck show view" do
          valid_params.merge!(follow_up_action: 'show')

          expect {
            put card_path(card), params: valid_params
          }.to change(Decks::Card, :count).by(0)

          expect(response).to redirect_to author_deck_url(deck.id)
          expect(flash[:notice]).to eq("Flashcard was successfully updated.")
        end
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { card: { front: "", back: card.back, deck_id: card.deck_id } } }

      it "responds with HTTP status unprocessable_entity(422)" do
        put card_path(card), params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:card) { create(:card, deck:) }

    it "deletes the card record" do
      expect {
        delete card_path(card)
      }.to change(Decks::Card, :count).by(-1)

      expect(response).to redirect_to author_deck_url(deck)
      expect(flash[:notice]).to eq("Flashcard was successfully deleted.")
    end
  end
end
