class ServicesController < ApplicationController
    def index
        @services = Service.all
    end
    
    def show
        @services = find(params(:id))
    end
    
    def new
    	@services = Service.new
    end

    def create
    	@services = Service.new(service_params)
    	if @services.save
    	    flash[:success] = "Service created"
    	    redirect_to @services
    	else
    	    flash.now[:danger] = "Unable to create services"
    	    render 'new'
    	end
    end
    
    def edit
    end

    def update
        @services = Service.find(params[:id])
        if @services.update(service_params)
            flash[:success] = "Service updated"
            redirect_to @services
        else
            flash.now[:danger] = "Failed to update service"
            render 'edit'
        end
    end
    
    def destroy
        @services = Service.find(params[:id])
        if current_user.admin
            @services.destroy
            flash[:success] = "#{@services.name} removed from the site"
            redirect_to services_path
        end
    end

    private

    def services_params
	    params.require(:services).permit(:church,
                				       :day_of_week,
                				       :start_time,
                				       :finish_time,
                				       :location)
    end
    
end