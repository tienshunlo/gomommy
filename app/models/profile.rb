class Profile < ActiveRecord::Base
  belongs_to :user
  self.primary_key = 'user_id'
  has_one :album, through: :profile_album
  has_one :profile_album
  store :setting, :accessors => [:visited]
  
  has_attached_file :profile_img, styles: { :original => ['200x200#' , :jpg], medium: "300x300>", thumb: "100x100>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :profile_img, content_type: /\Aimage\/.*\z/
  
  after_create :set_default_album
  after_save :check_profile
  # 註冊用after_create可以通過，可是後來更改地點的時候，after_create就不會更新到published
  # 註冊用after_save 會太深，可是如果更改地點會更新成published，改成update_all可以避免掉callback
  
  NUMBER_OF_BABY = [['有幾個小寶貝', 0], ['保密' , 1],['一個' , 2],['二個' , 3],['三個' , 4],['四個以上' , 5]]
  GENDER_OF_BABY = [['請輸入小寶貝性別', 0], ['保密' , 1],['女寶寶' , 2],['男寶寶' , 3]]

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

