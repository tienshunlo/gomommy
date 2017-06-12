class City < ActiveRecord::Base
  has_many :district
	has_many :hospital
	has_many :doctor
  def self.options_for_select
    order('id').map { |e| [e.name, e.id] }
  end
end

