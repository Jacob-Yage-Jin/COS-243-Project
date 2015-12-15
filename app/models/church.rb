class Church < ActiveRecord::Base
  belongs_to :user
  has_many :services, inverse_of: :church
  has_many :users
  has_many :users, through: :user_rides
  
  validates :name, presence: true
  validates :user, presence: true
  
  accepts_nested_attributes_for :services
end
