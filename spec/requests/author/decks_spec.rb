require 'rails_helper'

RSpec.describe "Author::Decks", type: :request do
  let!(:author) { create(:user) }

  before { sign_in author }

  describe "GET /index" do
    it "returns http success" do
      get author_decks_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "responds with HTTP status ok(200)" do
      deck = create(:deck, author:)
      get author_deck_path(deck)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /new" do
    it "responds with HTTP status ok(200)" do
      get new_author_deck_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context 'valid params' do
      let(:valid_params) { { deck: { title: 'Structural Design Patterns', description: 'Learn to identify structural design patterns.', author_id: author.id } } }

      context "with valid params" do
        it "responds with HTTP status redirect(302)" do
          post author_decks_path, params: valid_params

          expect(response).to have_http_status(:redirect)
        end

        it "creates an authored deck" do
          expect {
            post author_decks_path, params: valid_params
          }.to change(Deck, :count).by(1)
        end
      end
    end

    context 'invalid params' do
      # Missing required :title field
      let(:invalid_params) { { deck: { title: '', description: 'Learn to identify structural design patterns.', author_id: author.id } } }

      it "responds with HTTP status unprocessable entity(400)" do
        post author_decks_path, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create an authored deck' do
        expect {
          post author_decks_path, params: invalid_params
        }.to change(Quiz, :count).by(0)
      end
    end
  end

  describe "GET /edit" do
    let!(:deck) { create(:deck, author: author) }

    it "responds with HTTP status ok(200)" do
      get edit_author_deck_path(deck)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT /update" do
    let!(:deck) { create(:deck, author: author) }

    context "Valid params" do
      let(:valid_params) { deck.attributes.merge(title: 'Design Patterns') }

      it "responds with HTTP status redirect(302)" do
        put author_deck_path(deck), params: { deck: valid_params }

        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to eq(I18n.t("flash.decks.update.success"))
      end

      it "redirects to :show author_quiz_url" do
        put author_deck_path(deck), params: { deck: valid_params }

        expect(response).to redirect_to author_deck_url(deck)
      end
    end

    context "Invalid params" do
      let(:invalid_params) { deck.attributes.merge(title: '') }

      it "responds with HTTP status unprocessable_entity(422)" do
        put author_deck_path(deck), params: { deck: invalid_params }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders with an error message" do
        put author_deck_path(deck), params: { deck: invalid_params }

        expect(flash[:alert]).to eq(I18n.t("flash.decks.update.error"))
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:deck) { create(:deck, author: author) }

    context "Valid params" do
      it "responds with HTTP status redirect(302)" do
        delete author_deck_path(deck)

        expect(response).to have_http_status(:redirect)
      end

      it "renders with a success message" do
        delete author_deck_path(deck)

        expect(flash[:notice]).to eq(I18n.t("flash.decks.destroy.success"))
      end

      it "destroys the deck record" do
        expect {
          delete author_deck_path(deck)
        }.to change(Deck, :count).by(-1)
      end
    end

    context "Invalid params" do
      before do
        allow(deck).to receive(:destroy).and_return(false)
        allow(Deck).to receive(:find).and_return(deck)
      end

      it "responds with HTTP status redirect(302)" do
        delete author_deck_path(deck)

        expect(response).to have_http_status(:redirect)
      end

      it "renders with an error message" do
        delete author_deck_path(deck)

        expect(flash[:alert]).to eq(I18n.t("flash.decks.destroy.error"))
      end

      it "does not destroy the deck record" do
        expect {
          delete author_deck_path(deck)
        }.to change(Deck, :count).by(0)
      end
    end
  end
end
