class UsersController < ApplicationController
  skip_before_action :require_user
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User created."
      redirect_to root_path
    else
      flash[:danger] = "#{error_messages(@user.errors.full_messages)}"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
