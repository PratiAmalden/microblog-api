require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "POST /posts" do
    let(:params) { { post: attributes_for(:post) } }
    context "when authenticated" do

      before { sign_in user }

      it "creates a post for the current user" do
        expect {
          post posts_path, params: params 
        }.to change(Post, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "when unauthenticated" do
      it "returns unauthorized" do
        post posts_path, params: params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /posts" do
    before { sign_in user }

    it "doesn't allow deleting another user's post" do
      post = create(:post, user: other_user)
  
      expect{
        delete post_path(post)
      }.not_to change(Post, :count)

      expect(response).to have_http_status(:not_found)
      expect(Post.exists?(post.id)).to be(true)
    end

    it "allows deleting own post" do
      post = create(:post, user: user)
      expect {
        delete post_path(post)
      }.to change(Post, :count).by(-1)
      expect(response).to have_http_status(:no_content)
      expect(Post.exists?(post.id)).to be(false)
    end
  end
end
