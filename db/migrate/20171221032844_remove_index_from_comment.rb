class RemoveIndexFromComment < ActiveRecord::Migration
  def change
    remove_index :comments, column: :user_id
  end
end
