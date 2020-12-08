class PasswordResetController < ApplicationController
  def user_params
    params.require(:user).permit(:email)
  end

  def edit
    @id = User.where(email: user_params[:email]).pluck(:id)[0]
  end

  def create
    @id = User.find_by_email(user_params[:email])
    if @id == nil
      redirect_to new_password_reset_path
    end
  end

  def new

  end

  def show
    @id = User.where(email: user_params[:email]).pluck(:id)[0]
    render :edit

  end

  def update
    @id = User.where(email: user_params[:email]).pluck(:id)[0]
    render :edit

  end

end
