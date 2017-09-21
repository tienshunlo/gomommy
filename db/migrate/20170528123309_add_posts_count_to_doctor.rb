class AddPostsCountToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :post_count, :integer, :default => 0

    Doctor.pluck(:id).each do |i|
      Doctor.reset_counters(i, :post) # 全部重算一次
    end
  end
end
