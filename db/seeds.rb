# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

create_doctors = for i in 1..20 do
    Doctor.create!([name: "Doctor no.#{i}", specialty: "這是用種子建立的第 #{i} 個專長", experience: "這是用種子建立的第 #{i} 個經驗", hospital_id: i, gender: 0, city_id: i, district_id: i])
    City.create!([name: "City no.#{i}"])
    District.create!([name: " District no.#{i}", city_id:i])
    Hospital.create!([name: " Hospital no.#{i}", city_id:i, district_id:i])
    Phase.create!([title: " Phase no.#{i}"])
    Issue.create!([title: " Issue no.#{i}", phase_id:i])
end


