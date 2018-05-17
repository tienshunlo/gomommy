class Phase < ActiveRecord::Base
  belongs_to :phasecate
  has_many :post
  has_many :issue
  
  def self.options_for_select
    order('id').map { |e| [e.title, e.id] }
  end
  
  def self.with_posts
    includes(:post).where.not(posts: { id: nil })
  end
  
end
