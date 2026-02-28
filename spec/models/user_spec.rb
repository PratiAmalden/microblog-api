require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with a new name and email" do
      user = build(:user)
      expect(user).to be_valid
    end
  end

  describe "#feed_scope" do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }

    it "includes user's own posts" do
      micropost = create(:micropost, user: user_a)
      expect(user_a.feed_scope).to include(micropost)
    end

    it "includes followed users posts" do
      create(:follow, follower: user_a, followed: user_b)
      micropost = create(:micropost, user: user_b)

      expect(user_a.feed_scope).to include(micropost)
    end

    it "retrieve comment counts per post" do
      posts_with_comments = create(:micropost, :with_comments, user: user_a)
      
      feed_posts = user_a.feed_scope.to_a

      feed_post = feed_posts.find { |p| p.id == posts_with_comments.id }

      expect(feed_post.comments_count).to eq(3)
    end
  end

  describe "following" do
    it "can follow another user" do
      follower = create(:user)
      followed = create(:user)

      follower.followings << followed
      expect(follower.followings).to include(followed)
    end
  end
end