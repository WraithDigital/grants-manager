class SessionsController < ApplicationController

  skip_before_action :authenticate
  before_action      :logged_in_check, except: [:destroy]

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now[:error] = 'Email or password is invalid'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end

  def logged_in_check
    redirect_to(root_path) if logged_in?
  end

end
