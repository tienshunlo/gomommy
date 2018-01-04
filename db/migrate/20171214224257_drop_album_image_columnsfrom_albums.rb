class DropAlbumImageColumnsfromAlbums < ActiveRecord::Migration
  def change
    remove_column :albums, :album_img, :string
  end
end
