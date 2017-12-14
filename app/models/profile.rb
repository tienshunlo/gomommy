class Profile < ActiveRecord::Base
  belongs_to :user
  has_attached_file :profile_img, styles: { :original => ['200x200#' , :jpg], medium: "300x300>", thumb: "100x100>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :profile_img, content_type: /\Aimage\/.*\z/
  
  after_save :check_profile
  
  self.primary_key = 'user_id'
  
  private
  def check_profile
    if self.location?
      self.user.published!
    else
      self.user.draft!
    end
  end
  
end

