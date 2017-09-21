class Issue < ActiveRecord::Base
    has_many :post
    
    def self.options_for_select
        order('id').map { |e| [e.title, e.id] }
    end
  
end
