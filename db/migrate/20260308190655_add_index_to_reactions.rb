class AddIndexToReactions < ActiveRecord::Migration[8.1]
  def change
    add_index :reactions, [ :likable_type, :likable_id, :kind ]
  end
end
