require "rails_helper"

RSpec.describe "Home Page", type: :request do
  it "responds with HTTP status of success for all users" do
    get root_path
    expect(response).to have_http_status(:ok)
  end
end
