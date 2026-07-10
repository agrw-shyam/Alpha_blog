class ApplicationController < ActionController::Base
  # Makes these methods available inside your view files (.html.erb)
  helper_method :current_user, :logged_in?

  def current_user
    # Finds the user if a session exists, and caches it in an instance variable (@current_user)
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # Returns true if current_user exists, false if it is nil
    !!current_user
  end
end
