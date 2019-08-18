module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin

    helper_method :current_user

    def authenticate_admin
      if current_user.nil? || current_user.admin? == false
        flash[:alert] = 'You do not have authorization to access this page.'

        redirect_to root_path
      end
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
end
