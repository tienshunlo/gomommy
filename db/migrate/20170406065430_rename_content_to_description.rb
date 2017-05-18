class RenameContentToDescription < ActiveRecord::Migration
  def change
    rename_column :posts, :comment, :description
  end
end
