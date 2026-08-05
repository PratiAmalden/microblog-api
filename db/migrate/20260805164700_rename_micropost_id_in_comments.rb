class RenameMicropostIdInComments < ActiveRecord::Migration[8.1]
  def change
    rename_column :comments, :micropost_id, :post_id
  end
end
