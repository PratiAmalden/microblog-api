class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, presence: true, uniqueness: true

  has_many :followed_users, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :followed_users, source: :followed

  has_many :following_users, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :following_users, source: :follower

  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :reactions, dependent: :destroy

  def feed
    Micropost
      .where(user_id: followings.select(:id))
      .or(Micropost.where(user_id: id))
      .includes(:user)
      .order(created_at: :desc, id: :desc)
  end


  def filter_posts(keyword)
    return microposts unless keyword.present?
    microposts.where("body LIKE ?", "%#{keyword}%")
  end

  def follow(user)
    followed_users.create(followed: user)
  end

  def unfollow(user)
    followed_users.find_by(followed: user)&.destroy
  end
end
