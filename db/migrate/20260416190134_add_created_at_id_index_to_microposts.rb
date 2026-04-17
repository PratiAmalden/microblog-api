class AddCreatedAtIdIndexToMicroposts < ActiveRecord::Migration[8.1]
  def change
    add_index :microposts, [ :created_at, :id ], order: { created_at: :desc, id: :desc }
  end
end
