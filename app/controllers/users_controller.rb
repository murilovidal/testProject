class UsersController < ApplicationController
    skip_before_action :authorized, only: [:new, :create]
    def new
        @user = User.new
    end

    def index
        unless authorized?()
            @users = User.all
        end    
    end

    def create
        @user = User.new(user_params)

        if @user.save
            session[:user_id] = @user.id
            redirect_to '/home', notice: 'Bem Vindo!'
        else
            render 'new'
        end
    end


    private 
    def user_params
        params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end

    
end