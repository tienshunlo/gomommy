class DoctorAlbum < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :album
end
