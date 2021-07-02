class UsersController < ApplicationController
    def index
        render json: User.all
    end

    def create
        user = User.new(user_params)
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        user = User.find(params[:id])
        render json: user
    rescue ActiveRecord::RecordNotFound
        render plain: "User not found!"
    end

    def update
        user = User.find(params[:id])
        
        if user.update(user_params)
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    rescue ActiveRecord::RecordNotFound
        render plain: "User not found!"
    end

    def destroy
        user = User.find(params[:id])
        name = user.name
        if user.destroy
            render plain: "#{name} has been deleted!"
        else
            render json user.errors.full_messages, status: :unprocessable_entity
        end
    rescue ActiveRecord::RecordNotFound
        render plain: "User not found!"
    end

    def user_params
        params.require(:user).permit(:name, :email)
    end
end