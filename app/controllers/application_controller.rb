class ApplicationController < ActionController::Base
  before_filter :set_current_user, :set_current_game
  after_filter :flash_to_headers
  protect_from_forgery with: :exception

  def set_current_user
    @current_user ||= session[:session_token] && User.where(session_token: session[:session_token])
  end

  def set_current_game
    if @current_user
      if @current_user.select(:current_game).first.attributes.values[1]
        id = @current_user.select(:current_game).first.attributes.values[1]
        @current_game = Cardgame.where(game_id: id, started: true)
      end
    end
  end

  def flash_to_headers
    return unless request.xhr?
    response.headers['X-Message'] = flash[:notice] unless flash[:notice].blank?
    # repeat for other flash types...

    flash.discard  # don't want the flash to appear when you reload page
  end

  def check_session
    if @current_user
      redirect_to games_path
    end
  end

end
