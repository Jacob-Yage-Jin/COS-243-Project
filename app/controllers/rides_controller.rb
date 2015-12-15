class RidesController < ApplicationController
    def index
	order_param = (params[:order] || :Date).to_sym
	ordering = case order_param
		   when :Date
		       :date
		   when :Service
		       :service_id
		   end
	@rides = Ride.order(ordering)
    end
    
    def show
    	@rides = find(params(:id))
    	rescue
    		flash[:danger] = "Unable to find ride"
    		redirect_to rides_path
    end
    
    def new
    	@rides = Ride.new
    end
    
    def edit
    end
    
    def update
    	@rides = Ride.find(params[:id])
    	if @rides.update(ride_params)
    		flash[:success] = "Ride updated"
    		redirect_to @rides
    	else
    		flash.now[:danger] = "Failed to update ride"
    		render 'edit'
    	end
    end
    
    def create
    	@rides = Ride.new(ride_params)
    	@rides.user = current_user
    	if @rides.save
    		flash[:success] = "Ride created"
    	else
    		flash.now[:danger] = "Unable to create church"
    		render 'new'
    	end
    end
    
    def destroy
    	@rides = Ride.find(params[:id])
    	if current_user.admin
    		@rides.destroy
    		flash[:success] = "#{@rides.service_id} removed from the site"
    		redirect_to rides_path
    	end
    end
    
    private
    
    def ride_params
    	params.require(:ride).permit(:service_id,
    								 :user,
    								 :date,
    								 :leave_time,
    								 :return_time,
    								 :number_of_seats,
    								 :seats_available,
    								 :location,
    								 :vehicle)
    end
end
