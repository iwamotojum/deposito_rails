class SessionsController < ApplicationController
  skip_before_action :require_user, only: [:new, :create]
  before_action :verify_logged_in, only: [:new]

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in succesfully."
      redirect_to materials_path
    else
      flash[:danger] = "There was something wrong with your login attempt."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have been logged out."
    redirect_to login_path
  end

  private

  def verify_logged_in
    redirect_to root_path if logged_in?
  end
end