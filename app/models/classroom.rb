class Classroom < ActiveRecord::Base
	belongs_to :user
	has_many :classenrolls
end
