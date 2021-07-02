class DogRentalRequestsController < ApplicationController

    def new
        @request = DogRentalRequest.new
        render :new
    end

    def create
        @request = DogRentalRequest.new(request_params)
        if @request.save
            redirect_to dog_url(@request.dog)
        else
            flash[:errors] = @request.errors.full_messages
            redirect_to new_dog_rental_request_url
            
        end
    end

    def deny
        current_request.deny!
        redirect_to dog_url(current_dog)
    end

    def approve
        current_request.approve!
        redirect_to dog_url(current_dog)
    end
  
private

    def current_request
        @request ||= DogRentalRequest.includes(:dog).find(params[:id])
    end

    def current_dog
        current_request.dog
    end

    def request_params
        params.require(:dog_rental_request).permit(:start_date, :end_date, :dog_id, :status)
    end

end