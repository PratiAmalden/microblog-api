require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "POST /microposts/:micropost_id/comments" do
    let(:user) { create(:user) }
    let(:micropost_a) { create(:micropost, user: user) }

    it "create comment" do
      comment = create(:comment)
      
      expect { 
        post "/microposts/#{micropost_a.id}/comments",
        params: { comment: { body: "test" } },
        headers: auth_headers(user)
      }.to change { Micropost.find_by(id: micropost_a.id).comments_count }.by(1)
      expect(response).to have_http_status(:created)
    end
  end 
end
