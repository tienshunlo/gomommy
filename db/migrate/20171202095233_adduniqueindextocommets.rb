class Adduniqueindextocommets < ActiveRecord::Migration
  def change
    add_index(:comments, [:user_id, :post_id], unique: true)
  end
end
