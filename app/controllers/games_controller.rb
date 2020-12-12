class GamesController < ApplicationController

  def create
    redirect_to new_game_path
  end

  def index
    user_game_id = @current_user.select(:current_game).first.attributes.values[1]
    if user_game_id != 0
      flash[:notice] = "Your game: "+user_game_id+" is still running."
    end
  end

end
