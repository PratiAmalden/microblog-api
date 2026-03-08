require 'rails_helper'

RSpec.describe "Comments", type: :request do
    let(:user) { create(:user) }
    let(:micropost) { create(:micropost, user: user) }

  describe "POST /microposts/:micropost_id/comments" do
    it "create comment" do
      expect {
        post "/microposts/#{micropost.id}/comments",
        params: { comment: { body: "test" } },
        headers: auth_headers(user)
      }.to change(Comment, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end 
end
