class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :nickname, :message => "請記得輸入"
  validates :password, length: {minimum: 6, message: "密碼最少六位"}
  has_many :post, dependent: :destroy
  has_many :comment, dependent: :destroy
  has_one :profile, dependent: :destroy
  enum status: { draft: 0, published: 1 }
  
  after_create :build_profile

  def build_profile
    Profile.create(user: self) # Associations must be defined correctly for this syntax, avoids using ID's directly.
  end
end
