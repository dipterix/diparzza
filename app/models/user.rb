class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :classrooms
  has_many :classenrolls
  has_many :classannounces
  has_one :staff

  validates :email, presence: true

end
