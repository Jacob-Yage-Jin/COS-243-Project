class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :service
  has_many :user_rides
  has_many :users, through: :user_rides

    validates :user, presence: true
    validates :service, presence: true
    validates :leave_time, presence: true
    validates :return_time, presence: true
    
    validates :seats_available, presence: true, numericality: { only_integer: true, :greater_than_or_equal_to => 0 }
    validates :number_of_seats, presence: true, numericality: { only_integer: true, :greater_than_or_equal_to => 0 }
    validates :vehicle, presence: true
    validates :date, presence: true
    validates :meeting_location, presence: true
    
    validate :seats_available_less_than_number_of_seats
    validate :ride_return_cannot_be_too_early
    validate :ride_date_time_travel_not_valid

    
    def seats_available_less_than_number_of_seats
      if seats_available.present? && number_of_seats.present? && seats_available>number_of_seats
        errors.add(:seats_available, "seats available should not greater than number of seats")
      end
    end
    
    def ride_return_cannot_be_too_early
      if leave_time.present? && return_time.present? && leave_time > return_time
        errors.add(:return_time, "return time should not before leave time")
      end
    end
    
    def ride_date_time_travel_not_valid
      if date.present? && date < Date.today
        errors.add(:date, "time travel should not be valid")
      end
    end
    
    
end
