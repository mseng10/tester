class LobbyController < ApplicationController

  def create
    @game_id = SecureRandom.random_number(10000)
    @deck = Deck.create!({:cards => "1"})
    @discard = Deck.create!({:cards => "2"})
    @hand = Hand.create!({:user_id => @current_user.select(:id), :cards => "3"})
    Cardgame.create!({ :game_id => @game_id, :user_ids => @current_user.select(:id).to_s + ',',
                       :deck_ids => @deck.id.to_s + ',', :discard_ids => @discard.id.to_s + ',',
                       :hand_ids => @hand.id.to_s + ',', :started => false })
    redirect_to lobby_path(@game_id)
  end

  def join
    @game_id = params[:game][:game_id]
    redirect_to lobby_path(@game_id)
  end

end
