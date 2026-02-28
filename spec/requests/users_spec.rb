require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:password) { "secrete123" }
  let(:user) { create(:user, password: password ) }

  describe "POST /users/signup" do
    it "creates a user and returns success message" do
      expect {
        post "/users/signup",
        params: { user: attributes_for(:user)}
      }.to change(User, :count).by(1)

      expect(response).to have_http_status(:created)

      body = response.parsed_body
      expect(body[:message]).to eq("Signed up successfully")
    end

    it "returns validation failure" do
      post "/users/signup"

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "POST /users/signin" do
    it "returns JWT in Authorization header" do
      post "/users/signin", params: { user: { email: user.email, password: password } }

      expect(response).to have_http_status(:ok)
      expect(response.headers["Authorization"]).to be_present
    end
  end

  describe "POST /users/signout" do
    it "return ok when successfully signed out" do
      post "/users/signin", params: { user: { email: user.email, password: password } }

      token = response.headers["Authorization"]

      post "/users/signout", headers: { "Authorization" => token }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /feed" do
    it "allows access with valid JWT" do
      get feed_path, headers: auth_headers(user)

      expect(response).to have_http_status(:ok)
    end

    it "rejects access without JWT" do
      get feed_path

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
