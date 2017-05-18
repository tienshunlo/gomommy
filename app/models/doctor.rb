class Doctor < ActiveRecord::Base
	has_attached_file :doctor_img, styles: { :original => ['200x200#' , :jpg], medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :doctor_img, content_type: /\Aimage\/.*\z/
	belongs_to :hospital
	belongs_to :city
	belongs_to :district
	has_many :post, dependent: :destroy
	
	GENDER = [['女性' , 0],['男性' , 1]]
	scope :doctor_city, -> (city_id) { where city_id: city_id }
	
	scope :with_city_id, lambda { |city_ids|
    where(:city_id => [*city_ids])
  }
  
  scope :with_district_id, lambda { |district_ids|
  where(:district_id => [*district_ids])
}
	
	#scope :with_city_id, -> (city_id) { where city_id: city_id }
	#scope :with_district_id, -> (district_id) { where district_id: district_id }
	
	#scope :with_district_name, lambda { |district_name|
  #where(district: { name: district_name }).joins(:district)
#}
	
	scope :with_hospital_id, -> (hospital_id) { where hospital_id: hospital_id }
	scope :sorted_by, lambda { |sort_option|
  # extract the sort direction from the param value.
  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
  case sort_option.to_s
  when /^created_at_/
    # Simple sort on the created_at column.
    # Make sure to include the table name to avoid ambiguous column names.
    # Joining on other tables is quite common in Filterrific, and almost
    # every ActiveRecord table has a 'created_at' column.
    order("doctors.created_at #{ direction }")
  when /^name_/
    # Simple sort on the name colums
    order("LOWER(doctors.name) #{ direction }, LOWER(doctors.name) #{ direction }")
  when /^city_name_/
    # This sorts by a student's country name, so we need to include
    # the country. We can't use JOIN since not all students might have
    # a country.
    order("LOWER(city.name) #{ direction }").includes(:city)
  else
    raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
  end
}
	
	
	filterrific(
    	default_filter_params: { sorted_by: 'created_at_desc' },
		available_filters: [
    		:sorted_by,
    		:search_query,
    		:with_city_id,
    		:with_district_id,
    		:with_district_name,
    		:with_hospital_id,
    		]
    )
    
    def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Registration date (newest first)', 'created_at_desc'],
      ['Registration date (oldest first)', 'created_at_asc'],
      ['Country (a-z)', 'country_name_asc']
    ]
    end
    
    
	
end
