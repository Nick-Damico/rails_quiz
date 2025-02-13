require 'rails_helper'

RSpec.describe "Author::Decks", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get author_decks_path
      expect(response).to have_http_status(:success)
    end
  end
end
