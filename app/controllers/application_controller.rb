class ApplicationController < ActionController::Base
  before_filter :set_current_user
  protect_from_forgery with: :exception
  def set_current_user
    @current_user ||= session[:session_token] && User.where(session_token: session[:session_token])
  end

  def check_session
    if @current_user
      redirect_to games_path
    end
  end

end
