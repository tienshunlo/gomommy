class Hospital < ActiveRecord::Base
    belongs_to :city
	belongs_to :district
	has_many :doctor
	def self.options_for_select
        order('LOWER(name)').map { |e| [e.name, e.id] }
    end
end
