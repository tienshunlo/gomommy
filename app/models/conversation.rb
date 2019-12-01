class Conversation < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'
  has_many :message
  validates_presence_of :content, :message => "請記得輸入"
  #validates_length_of :content, :minimum => 10, :message => "要超過10個字"
end
