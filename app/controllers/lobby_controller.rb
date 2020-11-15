class LobbyController < ApplicationController

  def index
    @game_id = SecureRandom.random_number(10000)
  end

  def create
    redirect_to lobby_path(@game_id)
  end

end
