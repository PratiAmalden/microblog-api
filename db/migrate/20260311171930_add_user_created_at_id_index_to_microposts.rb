class AddUserCreatedAtIdIndexToMicroposts < ActiveRecord::Migration[8.1]
  def change
    add_index :microposts, [ :user_id, :created_at, :id ],
    order: { created_at: :desc, id: :desc }
  end
end
