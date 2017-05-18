class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.string :name
      t.integer :city_id
      t.integer :district_id

      t.timestamps null: false
    end
  end
end
