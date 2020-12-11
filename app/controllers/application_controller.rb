class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :authorized?
    before_action :authorized

    def current_user
        if session[:user_id]
          @current_user ||= User.find(session[:user_id])
        else
          @current_user = nil
        end
      end

    def logged_in?
        !current_user.nil?  
    end

    def authorized
        redirect_to '/' unless logged_in?
    end

    def authorized?
        @user = User.find_by(id: session[:user_id])
        unless current_user.role == 'admin'
          flash[:error] = "Você não está autorizado a acessar esta página."
          redirect_to '/home'
        end
    end
end
