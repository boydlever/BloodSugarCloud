class SessionsController < ApplicationController
  def new
  end
  def create
    email = params[:email].downcase
    user = User.find_by_email(email)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to bg_measurements_path, notice: 'Logged in!'
    else
      render :new
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to new_session_path, notice: 'Logged out!'
  end
end