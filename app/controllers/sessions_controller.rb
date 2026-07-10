class SessionsController < ApplicationController

  def new
  end

def create
  # 1. Find the user by their email input
  user = User.find_by(email: params[:session][:email].downcase)

  # 2. Authenticate their password
  if user && user.authenticate(params[:session][:password])
    # Log them in by saving their ID in the secure browser cookie session
    session[:user_id] = user.id
    
    # REDIRECT: Sends them straight to /users/id (e.g., /users/5)
    redirect_to user_path(user), notice: "Logged in successfully! Welcome back."
  else
    # If login fails, render the login form again with an alert
    flash.now[:alert] = "There was something wrong with your login details."
    render :new, status: :unprocessable_entity
  end
end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have been logged out."
  end

end