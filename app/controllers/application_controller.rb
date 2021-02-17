class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def authenticate_admin!
    authenticate_user!
    redirect_to articles_path, status: :forbidden unless current_user.admin?
  end

  def authenticate_banned!
    authenticate_user!
    redirect_to cancel_user_registration_path, status: :forbidden if current_user.banned?
  end
end
