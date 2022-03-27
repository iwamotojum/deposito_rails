class SessionsController < ApplicationController
  before_action :require_user, only: [:destroy]

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in succesfully."
      redirect_to root_path
    else
      flash.now[:alert] = "There was something wrong with your login attempt."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_path
  end
end