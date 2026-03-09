require 'rails_helper'

RSpec.describe "Follows", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:headers) { auth_headers(user) }
  let(:followed_id) { other_user.id }

  describe "POST /follow" do
    let(:params) { { follow: { followed_id: followed_id } } }

    subject(:do_request) { post follow_path, params: params, headers: headers }

    context "when authenticated" do
      it "creates a follow relationship" do
        expect { do_request }.to change(Follow, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(Follow.exists?(follower: user, followed: other_user)).to be true
      end
    end

    context "when trying to follow self" do
      let(:followed_id) { user.id }

      it "returns unprocessable entity" do
        expect { do_request }.not_to change(Follow, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when unauthorized" do
      it "returns unauthorized" do
        expect { post follow_path, params: params }.not_to change(Follow, :count)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when already following" do
      before { create(:follow, follower: user, followed: other_user) }

      it "doesn't create duplicate follow" do
        expect { do_request }.not_to change(Follow, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "POST /unfollow" do
    let!(:follow) { create(:follow, follower: user, followed: other_user) }
    let(:params) { { followed_id: followed_id } }

    subject(:do_request) { post unfollow_path, params: params, headers: headers }

    it "unfollows a user" do
      expect {
        do_request
      }.to change(Follow, :count).by(-1)
      expect(response).to have_http_status(:no_content)
      expect(Follow.exists?(follower: user, followed: other_user)).to be(false)
    end

    it "return unauthorized" do
      expect {
        post unfollow_path, params: params
      }.not_to change(Follow, :count)
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
