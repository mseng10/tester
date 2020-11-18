class UsersController < ApplicationController

  def user_params
    params.require(:user).permit(:username, :email, :password)
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
    end

    @user = User.create_user(user_params)
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

