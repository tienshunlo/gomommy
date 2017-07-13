class Phase < ActiveRecord::Base
  has_many :post
  has_many :issue
  
  def self.options_for_select
    order('id').map { |e| [e.title, e.id] }
  end
  
end
