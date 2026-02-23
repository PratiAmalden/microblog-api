class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, uniqueness: { scope: :followed_id }

  validate :user_cannot_follow_self

  private

  def user_cannot_follow_self
    errors.add(followed_id: "Can't be the same as follower") if followed_id == follower_id
  end
end
