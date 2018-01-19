class CreateDoctorAlbums < ActiveRecord::Migration
  def change
    create_table :doctor_albums do |t|
      t.references :doctor, index: true, foreign_key: true
      t.references :album, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
