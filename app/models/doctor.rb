class Doctor < ActiveRecord::Base
	has_attached_file :doctor_img, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :doctor_img, content_type: /\Aimage\/.*\z/
end
