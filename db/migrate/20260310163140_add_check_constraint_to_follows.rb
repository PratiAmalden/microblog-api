class AddCheckConstraintToFollows < ActiveRecord::Migration[8.1]
  def change
    add_check_constraint :follows,
      "followed_id <> follower_id", name: "no_self_follow"
  end
end
