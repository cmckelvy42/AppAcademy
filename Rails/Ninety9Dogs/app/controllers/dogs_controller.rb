class DogsController < ApplicationController
    def index
        @dogs = Dog.all
        render :index
    end

    def show
        @dog = Dog.find_by(id: params[:id])
        if @dog
            render :show
        else
            redirect_to dogs_url
        end
    end

    def new
        @dog = Dog.new
        render :new
    end

    def create
        @dog = Dog.new(dog_params)
        if @dog.save
            redirect_to dog_url(@dog)
        else
            flash.now[:errors] = @dog.errors.full_messages
            render :new
        end
    end

    def edit
        @dog = Dog.find_by(id: params[:id])
        if @dog
            render :edit
        else
            flash.now[:errors] = "Dog not found!"
            redirect_to dogs_url
        end
    end

    def update
        @dog = Dog.find_by(id: params[:id])
        if @dog.update(dog_params)
            redirect_to dog_url(@dog)
        else
            flash.now[:errors] = @dog.errors.full_messages
            render :edit
        end
    end

private
    def dog_params
        params.require(:dog).permit(:birth_date, :color, :description, :name, :sex)
    end

end