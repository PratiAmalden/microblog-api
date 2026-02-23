class Comment < ApplicationRecord
  belongs_to :micropost, counter_cache: :comments_count
  belongs_to :user

  validates :body, presence: true
end
