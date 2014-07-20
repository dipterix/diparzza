class Classroom < ActiveRecord::Base
	belongs_to :user
	has_many :classenrolls
	has_many :classannounces
end
