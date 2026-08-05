require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
    it "is invalid without title" do
      post = build(:post, title: nil)
      expect(post).not_to be_valid
    end

    it "has limit length of 140 chars" do
      post = build(:post, body: "a" * 141)
      expect(post).not_to be_valid
      expect(post.errors[:body]).to include("is too long (maximum is 140 characters)")
    end

    it "is valid with 140 characters" do
      post = build(:post, body: "a" * 140)
      expect(post).to be_valid
    end
  end

  describe "associations" do
    it "can have many comments" do
      post = create(:post, :with_comments)
      expect(post.comments.count).to eq(3)
    end

    it "belongs to a user" do
      user = create(:user)
      post = build(:post, user: user)
      expect(post.user).to eq(user)
    end
  end
end
