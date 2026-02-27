class AddBodyLimitInMicroposts < ActiveRecord::Migration[8.1]
  def change
    change_column :microposts, :body, :text, limit: 140
  end
end
