class SessionsController < ApplicationController
  def user_params
    params.require(:user).permit(:username, :password)
  end

  def new
    check_session
  end

  def create

    id= user_params[:username]
    password= user_params[:password]

    if id == '' or password == '' or id == nil or password == nil
      flash[:notice] = "Username and/or password fields are blank."
      redirect_to login_path and return
    elsif User.where(:username => id).empty?
      flash[:notice] = "Invalid user-id/password combination."
      redirect_to login_path and return
    else
      stored_password= BCrypt::Password.new(User.find_by(:username => id).password)
      if stored_password != password
        flash[:notice] = "Invalid user-id/password combination."
        redirect_to login_path and return
      else
        session_token = User.find_by(:username => id).session_token
        session[:session_token] = session_token
        flash[:notice] = "Successful login! You are logged in as #{id}"
      end
    end
    redirect_to '/games'
  end

  def destroy
    session[:session_token] = nil
    flash[:notice] = "Logged out of user"
    redirect_to login_path
  end
end
