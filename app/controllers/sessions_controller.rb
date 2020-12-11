class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password]) && @user.role != "admin"
       session[:user_id] = @user.id
       redirect_to '/home'
    elsif @user && @user.authenticate(params[:password]) && @user.role == "admin"
      session[:user_id] = @user.id
      redirect_to '/admin'
    else
       redirect_to '/', notice: "Email ou senha inválido."
    end
  end

  def destroy    
    session[:user_id] = nil         
    redirect_to '/', notice: "Saiu."
  end

  def welcome
  end

  private
  def session_params
    params.require(:user).permit(:email, :password)
  end
end
