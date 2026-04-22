class Comment < ApplicationRecord
  belongs_to :micropost, counter_cache: :comments_count
  belongs_to :user

  validates :body, presence: true

  has_many :reactions, as: :likable, dependent: :destroy

  scope :with_reactions, -> { includes(:reactions) }

  def deletable_by?(user)
    user == self.user || user == micropost.user
  end
end
