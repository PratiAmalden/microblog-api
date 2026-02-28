require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "POST /microposts" do
    let(:params) { { micropost: attributes_for(:micropost) } }
    context "when authenticated" do

      before { sign_in user }

      it "creates a micropost for the current user" do
        expect {
          post microposts_path, params: params 
        }.to change(Micropost, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "when unauthenticated" do
      it "returns unauthorized" do
        post microposts_path, params: params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /microposts" do
    before { sign_in user }

    it "doesn't allow deleting another user's post" do
      micropost = create(:micropost, user: other_user)
  
      expect{
        delete micropost_path(micropost)
      }.not_to change(Micropost, :count)

      expect(response).to have_http_status(:not_found)
      expect(Micropost.exists?(micropost.id)).to be(true)
    end

    it "allows deleting own post" do
      micropost = create(:micropost, user: user)
      expect {
        delete micropost_path(micropost)
      }.to change(Micropost, :count).by(-1)
      expect(response).to have_http_status(:no_content)
      expect(Micropost.exists?(micropost.id)).to be(false)
    end
  end
end
