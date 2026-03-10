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

    describe "DELETE /microposts/:micropost_id/comments/:id" do
        let!(:comment) { create(:comment, user: user, micropost: micropost) }

      it "return forbidden for unauthorized user" do
        user_a = create(:user)
        expect {
          delete "/microposts/#{micropost.id}/comments/#{comment.id}",
          headers: auth_headers(user_a)
      }.not_to change(Comment, :count)

        expect(response).to have_http_status(:forbidden)
      end

      it "delete when authorized" do
        expect {
          delete "/microposts/#{micropost.id}/comments/#{comment.id}",
          headers: auth_headers(user)
        }.to change(Comment, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end
end
