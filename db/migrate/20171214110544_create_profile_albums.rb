class CreateProfileAlbums < ActiveRecord::Migration
  def change
    create_table :profile_albums do |t|
      t.timestamps null: false
    end
  end
end
