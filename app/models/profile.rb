class Profile < ActiveRecord::Base
  belongs_to :user
  self.primary_key = 'user_id'
  has_one :album, through: :profile_album
  has_one :profile_album
  
  has_attached_file :profile_img, styles: { :original => ['200x200#' , :jpg], medium: "300x300>", thumb: "100x100>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :profile_img, content_type: /\Aimage\/.*\z/
  
  after_create :set_default_album
  after_save :check_profile
  # 註冊用after_create可以通過，可是後來更改地點的時候，after_create就不會更新到published
  # 註冊用after_save 會太深，可是如果更改地點會更新成published，改成update_all可以避免掉call_back
  
  NUMBER_OF_BABY = [['保密' , 0],['一個' , 1],['二個' , 2],['三個' , 3],['四個以上' , 4]]
  GENDER_OF_BABY = [['保密' , 0],['女寶寶' , 1],['男寶寶' , 2]]
  
  private
  def check_profile
    if self.location?
      User.where(:id => self.user_id).update_all(:status => "1")
    else
      User.where(:id => self.user_id).update_all(:status => "0")
    end
  end
  def set_default_album
    ProfileAlbum.create(profile_id: self.id, album_id: Album.last.id)
  end
  
  
end

