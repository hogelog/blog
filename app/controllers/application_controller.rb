class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_login_user

  protected

  def require_login
    unless @login_user
      redirect_to login_path
    end
  end

  def set_login_user
    if session[:user_id]
      @login_user = User.find(session[:user_id])
    end
  end

  def unauthorized_error(exception)
    render xml: exception, status: :unauthorized
  end
end
