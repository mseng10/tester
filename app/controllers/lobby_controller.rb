class LobbyController < ApplicationController

  def create
    user_id = @current_user.select(:id).first.attributes.values[0]
    game_id = SecureRandom.random_number(10000)
    deck = Deck.create!({:cards => "1"})
    discard = Deck.create!({:cards => "2"})
    hand = Hand.create!({:user_id => user_id, :cards => "3"})

    Cardgame.create!({ :game_id => game_id, :user_ids => [user_id, 123],
                           :deck_ids => deck.id.to_s + ',', :discard_ids => discard.id.to_s + ',',
                           :hand_ids => hand.id.to_s + ',', :started => false })
    redirect_to lobby_path(game_id)
  end

  def join
    game_id = params[:game][:game_id]
    user_id = @current_user.select(:id).first.attributes.values[0]
    if Cardgame.exists?(game_id: game_id)

      # Add user to game table
      old_users = Cardgame.user_ids(game_id)
      Cardgame.where(game_id: game_id).update_all(user_ids: old_users.append(user_id))

      # Add new hand to the database
      # TODO: finish
      redirect_to lobby_path(game_id)
    else
      flash[:notice] = 'Game does not exist'
      redirect_to games_path
    end
  end

end
