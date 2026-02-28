require 'rails_helper'

RSpec.describe Micropost, type: :model do
  describe "validations" do
    it "is invalid without title" do
      micropost = build(:micropost, title: nil)
      expect(micropost).not_to be_valid
    end

    it "has limit length of 140 chars" do
      micropost = build(:micropost, body: "a" * 141)
      expect(micropost).not_to be_valid
      expect(micropost.errors[:body]).to include("is too long (maximum is 140 characters)")
    end

    it "is valid with 140 characters" do
      micropost = build(:micropost, body: "a" * 140)
      expect(micropost).to be_valid
    end
  end

  describe "associations" do
    it "can have many comments" do
      micropost = create(:micropost, :with_comments)
      expect(micropost.comments.count).to eq(3)
    end

    it "belongs to a user" do
      user = create(:user)
      micropost = build(:micropost, user: user)
      expect(micropost.user).to eq(user)
    end
  end
end
