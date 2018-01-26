class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :authenticate

  helper_method :current_user, :logged_in?

  def current_user
    @user ||= User.find(session[:user_id])
  end

  def logged_in?
    session[:user_id].present?
  end

  def authenticate
    redirect_to(login_path) unless logged_in?
  end

  def authorize_admin
    redirect_to(root_path) unless current_user.admin?
  end

  def unauthorized
    head(:unauthorized)
  end

  def unprocessable
    head(:unprocessable_entity)
  end

end
