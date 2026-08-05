require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "is invalid without body" do
    comment = build(:comment, body: nil)
    expect(comment).not_to be_valid
  end

  describe "Counter Cache" do
    it "post.comments_count increase when comment is created" do
      post = create(:post)
      expect {
        create(:comment, post: post)
      }.to change { 
        post.reload.comments_count
      }.by(1)
    end
  end
end
