class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?
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
end
