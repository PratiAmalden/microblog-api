class CreateMicroposts < ActiveRecord::Migration[8.1]
  def change
    create_table :microposts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :comments_count, default: 0, null: false

      t.timestamps
    end
  end
end
