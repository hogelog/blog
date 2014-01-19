class AdminController < ApplicationController
  before_action :set_login_user

  protected

  def require_login
    unless @login_user
      redirect_to admin_login_path
    end
  end

  def set_login_user
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      return @login_user = user if user
    end
    expires_in 30.minutes, public: true
  end

  def unauthorized_error(exception)
    head 401
  end
end

