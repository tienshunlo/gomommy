class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_voter
  act_as_bookmarker
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, password_length: 6..128
  validates_presence_of :nickname, :message => "請記得輸入"
  has_many :post, dependent: :destroy
  has_many :comment, dependent: :destroy
  has_many :sent_conversation, :class_name => 'Conversation', :foreign_key => 'sender_id'
  has_many :received_conversation, :class_name => 'Conversation', :foreign_key => 'recipient_id'
  has_many :message, dependent: :destroy
  #has_many :sent_message, :class_name => 'Message', :foreign_key => 'sender_id'
  #has_many :received_message, :class_name => 'Message', :foreign_key => 'recipient_id'
  has_one :profile, dependent: :destroy
  enum status: { draft: 0, published: 1 }
  
  after_create :build_profile

  def build_profile
    Profile.create(user: self) # Associations must be defined correctly for this syntax, avoids using ID's directly.
  end
end
