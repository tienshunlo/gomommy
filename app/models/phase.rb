class Phase < ActiveRecord::Base
  has_many :post
  has_many :issue
end
