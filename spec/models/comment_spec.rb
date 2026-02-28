require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "is invalid without body" do
    comment = build(:comment, body: nil)
    expect(comment).not_to be_valid
  end

  describe "Counter Cache" do
    it "micropost.comment_count increase when comment is created" do
      micropost = create(:micropost)
      expect {
        create(:comment, micropost: micropost)
      }.to change { 
        micropost.reload.comments_count
      }.by(1)
    end
  end
end
