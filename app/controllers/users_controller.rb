class UsersController < ApplicationController

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def show

  end

  def index

  end

  def new

  end

  def create

    if User.exists?(user_id: user_params[:user_id])
      flash[:notice] = "Sorry, this user-id is taken. Try again"
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

