class GamesController < ApplicationController

  def create
    redirect_to new_game_path
  end

  def index
    user_game_id = @current_user.select(:current_game).first.attributes.values[1]
    if user_game_id != 0
      id = Cargame.where(game_id: game_id).pluck(:id)
      Cargame.delete(id)
      flash[:notice] = "Your previous game with ID "+user_game_id+" was deleted!"
    end
  end

end
