class AddNotNullToMicropostsBody < ActiveRecord::Migration[8.1]
  def change
    change_column_null :microposts, :body, false
  end
end
