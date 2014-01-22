class Admin::LoginController < AdminController

  rescue_from User::InvalidUser, with: :unauthorized_error

  def show
  end

  def login
    login_user = User.login_user(login_params)
    session[:user_id] = login_user.id
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  def google_oauth2
    omniauth = request.env['omniauth.auth']
    google_auth_user = GoogleAuthUser.find_by(provider: omniauth[:provider], uid: omniauth[:uid])
    if google_auth_user
      session[:user_id] = google_auth_user.user_id
      redirect_to admin_path
    else
      head 401
    end
  end

  private

  def login_params
    params.require(:login).permit(:username, :password)
  end
end
