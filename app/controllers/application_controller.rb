class ApplicationController < ActionController::Base
  protect_from_forgery

  private 

  def reset_session_expires
    request.session_options[:expire_after] = 2.weeks
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

end
