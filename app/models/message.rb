class Message < ActiveRecord::Base
  belongs_to :recipient, :class_name => 'User'
  belongs_to :sender, :class_name => 'User'
  belongs_to :conversation
  validates_presence_of :content, :message => "請記得輸入"
end
