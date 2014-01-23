class Admin::LoginController < AdminController
  skip_before_action :require_login

  def show
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
end
