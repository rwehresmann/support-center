module Admin
  class UsersController < Admin::ApplicationController
    def authenticate_as_user
      @user = User.find(params[:id])

      session[:user_id] = @user.id

      redirect_to root_path
    end
  end
end
