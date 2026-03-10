class CreateReactions < ActiveRecord::Migration[8.1]
  def change
    create_table :reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :likable, polymorphic: true, null: false
      t.integer :kind

      t.timestamps
    end

    add_index :reactions, [ :user_id, :likable_id, :likable_type ], unique: true
  end
end
