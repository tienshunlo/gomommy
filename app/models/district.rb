class District < ActiveRecord::Base
    belongs_to :city
    has_many :doctor
    has_many :hospital
    def self.options_for_select
        order('LOWER(name)').map { |e| e }
    end
    
end
