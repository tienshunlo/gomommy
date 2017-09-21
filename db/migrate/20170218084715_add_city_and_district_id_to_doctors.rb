class AddCityAndDistrictIdToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :city_id, :integer
    add_column :doctors, :district_id, :integer
  end
end
