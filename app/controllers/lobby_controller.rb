class LobbyController < ApplicationController

  def create
    @game_id = SecureRandom.random_number(10000)
    redirect_to lobby_path(@game_id)
  end

end
