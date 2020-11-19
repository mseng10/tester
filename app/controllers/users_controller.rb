class UsersController < ApplicationController

  def user_params
    params.require(:user).permit(:username, :email, :password, :password2)
  end

  def show

  end

  def index

  end

  def new

  end

  def create

    if User.exists?(username: user_params[:username])
      flash[:notice] = "Sorry, this user-id is taken. Please try again"
      redirect_to new_user_path
      return
    elsif User.exists?(email: user_params[:email])
      flash[:notice] = "Sorry, email is already registered to an account. Please try a different one."
      redirect_to new_user_path
      return
    elsif !user_params[:password].eql?(user_params[:password2])
      flash[:notice] = "Sorry, the passwords you have entered do not match. Please try again."
      redirect_to new_user_path
      return
    else
      params = user_params
      params.delete(:password2)
    end


    @user = User.create_user(params)
    flash[:notice] = "Welcome #{@user.username}. Your account has been created."
    redirect_to login_path

  end

  def edit

  end

  def update

  end

  def destroy

  end

end

