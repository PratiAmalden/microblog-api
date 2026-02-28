require 'rails_helper'

RSpec.describe "Follows", type: :request do
  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }

  describe "POST /follows" do
    subject(:do_request) { post follow_path, params: params }

    let(:params) { { follow: { followed_id: followed_id } } }
    let(:followed_id) { user_b.id }

    context "when authenticated" do
      before { sign_in user_a }

      it "creates the follow" do
        expect { do_request }.to change(Follow, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(Follow.exists?(follower: user_a, followed: user_b)).to be(true)
      end
    end

    context "when trying to follow self" do
      before { sign_in user_a }
      let(:followed_id) { user_a.id }

      it "returns an error" do
        expect { do_request }.not_to change(Follow, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when unauthorized follow" do
      it "return unauthorized" do
        expect { do_request }.not_to change(Follow, :count)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when already following" do
      before do
        sign_in user_a
        create(:follow, follower: user_a, followed: user_b)
      end
      it "doesn't create duplicate follow" do
        expect { do_request }.not_to change(Follow, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end

  describe "DELETE /follows" do
    it "unfollows a user" do
      sign_in user_a 
      create(:follow, follower: user_a, followed: user_b)

      expect {
        delete unfollow_path, params: { followed_id: user_b.id }
      }.to change(Follow, :count).by(-1)
      expect(response).to have_http_status(:no_content)
      expect(Follow.exists?(follower: user_a, followed: user_b)).to be(false)
    end

    it "return unauthorized" do
      create(:follow, follower: user_a, followed: user_b)

      expect {
        delete unfollow_path, params: { followed_id: user_b.id }
      }.not_to change(Follow, :count)
      expect(response).to have_http_status(:unauthorized)
    end
  end
end