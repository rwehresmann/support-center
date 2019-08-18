class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_admin_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_admin_user
    @current_admin_user ||= User.find_by(id: session[:admin_user_id])
  end
end
