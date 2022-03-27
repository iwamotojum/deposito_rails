class SessionsController < ApplicationController
  skip_before_action :require_user, only: [:new, :create]

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in succesfully."
      redirect_to materials_path
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