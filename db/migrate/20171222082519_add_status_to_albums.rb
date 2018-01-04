class AddStatusToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :category, :integer, default: 0
  end
end
