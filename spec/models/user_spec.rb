require "rails_helper"

RSpec.describe User, type: :model do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

  describe "validations" do
    it "is invalid without an email" do
      expect(build(:user, email: nil)).not_to be_valid
    end
  end

  describe "#feed" do
    it "includes user's own posts" do
      micropost = create(:micropost, user: user)
      expect(user.feed).to include(micropost)
    end

    it "includes followed users posts" do
      create(:follow, follower: user, followed: other_user)
      micropost = create(:micropost, user: other_user)

      expect(user.feed).to include(micropost)
    end

    it "retrieve comment counts per post" do
      posts_with_comments = create(:micropost, :with_comments, user: user)

      expect(user.feed.find(posts_with_comments.id).comments_count).to eq(3)
    end
  end

  describe "#follow" do
    it "creates a follow relationship" do
      expect {
        user.follow(other_user)
      }.to change(Follow, :count).by(1)
      expect(user.followings).to include(other_user)
    end
  end

  describe "#unfollow" do
    before do
      user.follow(other_user)
    end

    it "removes the follow relationship" do
      expect {
        user.unfollow(other_user)
      }.to change(Follow, :count).by(-1)
    end
  end

  it "does not allow following self" do
    expect {
      user.follow(user)
    }.not_to change(Follow, :count)
  end
end
