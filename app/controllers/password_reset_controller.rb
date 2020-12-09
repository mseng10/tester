class PasswordResetController < ApplicationController
  def user_params
    params.require(:user).permit( :email,:password, :password2)
  end

  def create
    if User.exists?(email: user_params['email'])
      User.find_by_email(user_params['email']).update_attributes!(:password=> BCrypt::Password.create(user_params['password']))
      redirect_to login_path
      flash[:notice] = "Password changed successfully!"
      return
    end
    redirect_to new_password_reset_path
    flash[:notice] = "Could not find an account with that email."
  end

  def new

  end


end
