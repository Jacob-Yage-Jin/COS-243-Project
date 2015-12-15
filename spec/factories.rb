FactoryGirl.define do
    factory :user do
		sequence(:name) { |i| "User #{i}" }
		sequence(:email) { |i| "user.#{i}@example.com" }
		password 'password'
		password_confirmation 'password'

		factory :admin do
		    admin true
		end
    end

    factory :church do
    	name "UCC"
    	user
		transient { num_services 1 }

		after(:create) do |church, evaluator|
	    	create_list(:service, evaluator.num_services, church: church)
		end
    end

    factory :service do
		church
		start_time "7:00"
		finish_time "9:00"
		day_of_week "1"
		location "location"
		transient { num_rides 1 }

		after(:create) do |service, evaluator|
	    	create_list(:ride, evaluator.num_rides, service: service)
		end
    end

    factory :ride do
    	user
    	service
    	leave_time "6:00"
    	return_time "10:00"
    	number_of_seats "7"
    	seats_available "5"
    	vehicle "van"
    	date "2015-12-16"
    	meeting_location "DC"
		transient { num_riders 1 }

		after(:create) do |ride, evaluator|
	    	ride.users = create_list(:user, evaluator.num_riders)
		end
    end

    factory :user_ride do
    	user
    	ride
    end
end
