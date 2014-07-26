class Classannounce < ActiveRecord::Base
	belongs_to :classroom
	belongs_to :user

	validates :user_id, presence: true
	validates :classroom_id, presence: true
end
