class GamesController < ApplicationController

  def create
    redirect_to new_game_path
  end

end
