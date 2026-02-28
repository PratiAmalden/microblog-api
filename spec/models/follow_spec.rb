require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }

  describe "associations" do
    it { should belong_to(:follower).class_name("User") }
    it { should belong_to(:followed).class_name("User") }
   
  end

  describe "validations" do
    it "can't follow self" do  
    follow = build(:follow, follower: user_a, followed: user_a)

    follow.validate
    expect(follow.errors[:followed]).to include("Can't be the same as follower")
  end
  end
end
