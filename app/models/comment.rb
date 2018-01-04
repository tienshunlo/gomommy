class Comment < ActiveRecord::Base
    belongs_to :post, counter_cache: :comment_count
    belongs_to :user
end
