class ProfileAlbum < ActiveRecord::Base
  belongs_to :profile
  belongs_to :album
  
end
