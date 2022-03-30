class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :require_user, :error_messages

  before_action :require_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
   
  def logged_in?
    !!current_user
  end
   
  def require_user
    if !logged_in?
      flash[:warning] = "You must be logged in to perform that action."
      redirect_to login_path
    end
  end

  def error_messages(errors_list)
    text = "Error#{'s' if errors_list.length > 1}: "
    count = 0

    errors_list.each do |error|
      count += 1
      return text += error + '.' if count == errors_list.count

      text += error + ', '
    end

    text
  end
end
