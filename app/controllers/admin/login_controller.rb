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

  private

  def login_params
    params.require(:login).permit(:username, :password)
  end
end
