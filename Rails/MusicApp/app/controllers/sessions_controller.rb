class SessionsController < ApplicationController
    def create
        user = User.lookup_by_email(params[:user][:email], params[:user][:password])
        if user.nil?
            flash.now[:errors] << "Invalid credentials"
            render :new
        else
            login_user!(user)
            redirect_to users_url
        end
    end

    def new
        if current_user
            redirect_to users_url
        else
            render :new
        end
    end

    def destroy
        logout_user if current_user
        redirect_to users_url
    end
end