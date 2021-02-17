class UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def set_banned
    @user = User.find(current_user.id)
    @user.banned = true
  end

  def toggle_admin
    @user = User.find(params[:id])
    @user.admin = !@user.admin
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_path }
        format.js
      else
        format.html { render action: 'new' }
        format.js
      end
    end
  end
end
