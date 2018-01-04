class AddForeignKeyToProfileAlbums < ActiveRecord::Migration
  def change
      add_column :profile_albums, :profile_id, :integer
      add_column :profile_albums, :album_id, :integer
      add_foreign_key :profile_albums, :profiles,  primary_key: :user_id
      add_foreign_key :profile_albums, :albums
  end
end
