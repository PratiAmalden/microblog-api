class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :likable, polymorphic: true

  enum :kind, { like: 0, dislike: 1 }

  validates :user_id, uniqueness: { scope: [ :likable_id, :likable_type, :kind ] }
  validates :user_id, uniqueness: { scope: [ :likable_id, :likable_type ] }

  private

  def self.react(user:, kind:, likable:)
    reaction = find_or_initialize_by(user: user, likable: likable)
    reaction.kind = kind
    reaction.save!
    reaction
  end

  scope :likes, -> { where(kind: :like) }
  scope :dislikes, -> { where(kind: :dislike) }
end
