class Comment < ActiveRecord::Base
    belongs_to :post, counter_cache: :comment_count
    belongs_to :user
    validates_presence_of :content, :message => "請記得輸入"
    #validates :content, :presence => true 兩種presenc的寫法都可以
end
