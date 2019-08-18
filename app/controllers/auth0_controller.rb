class Auth0Controller < ApplicationController
  def callback
    session[:userinfo] = request.env['omniauth.auth']

    redirect_to root_path
  end

  def failure
  end
end
