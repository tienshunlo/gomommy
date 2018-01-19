class Album < ActiveRecord::Base
    enum category: { cat_doctor: 0, cat_user: 1, cat_mamabook: 2 }
    has_attached_file :album_img, styles: { :original => ['200x200#' , :jpg], medium: "300x300>", thumb: "100x100>" }, default_url: ":style/missing.png"
    validates_attachment_content_type :album_img, content_type: /\Aimage\/.*\z/
    
    has_one :doctor, through: :doctor_album  
    has_one :doctor_album
    
    has_one :profile, through: :profile_album
    has_one :profile_album
end
