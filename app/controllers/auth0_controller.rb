class Auth0Controller < ApplicationController
  def authentication
    redirect_to(
      "https://#{ENV.fetch('AUTH0_DOMAIN')}/authorize?" +
      "client_id=#{ENV.fetch('AUTH0_CLIENT_ID')}&" +
      "response_type=code&" +
      "redirect_uri=#{URI.encode(auth_callback_url)}"
    )
  end

  def callback
    user = find_or_create_user

    session[:user_id] = user.id

    if user.admin?
      session[:admin_user_id] = user.id

      redirect_to admin_root_path
    else
      redirect_to root_path
    end
  end

  def failure
  end

  def logout
    if admin_logged_as_another_user?
      accessed_user = session[:user_id]
      session[:user_id] = session[:admin_user_id]

      redirect_to admin_user_path(accessed_user)
    else
      session.delete(:user_id)
      session.delete(:admin_user_id)

      redirect_to(
        "https://#{ENV.fetch('AUTH0_DOMAIN')}/v2/logout?" +
        "client_id=#{ENV.fetch('AUTH0_CLIENT_ID')}&" +
        "returnTo=#{URI.encode(root_url)}"
      )
    end
  end

  private

  def find_or_create_user
    info = request.env.fetch('omniauth.auth').fetch('info')
    user_email = info.fetch('email')
    user = User.find_by(email: user_email)

    return user if user

    User.create!(email: user_email)
  end

  def admin_logged_as_another_user?
    session[:user_id] != session[:admin_user_id]
  end
end
