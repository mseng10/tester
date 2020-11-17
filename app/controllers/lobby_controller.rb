class LobbyController < ApplicationController

  def create
    # TODO: Implement fixed game code length
    # https://stackoverflow.com/questions/44031239/generating-random-number-of-length-6-with-securerandom-in-ruby
    game_id = SecureRandom.random_number(10000)

    # Verifies unique game id
    while Cardgame.exists?(game_id: game_id)
      game_id = SecureRandom.random_number(10000)
    end

    user_id = @current_user.select(:id).first.attributes.values[0]  # Gets the user id from current user
    deck = Deck.create!({:cards => "1"})
    discard = Deck.create!({:cards => "2"})
    hand = Hand.create!({:user_id => user_id, :cards => "3"})

    Cardgame.create!({ :game_id => game_id, :user_ids => [user_id],
                           :deck_ids => [deck.id], :discard_ids => [discard.id],
                           :hand_ids => [hand.id], :started => false })

    redirect_to lobby_path(game_id)
  end

  def join
    game_id = params[:game][:game_id]
    user_id = @current_user.select(:id).first.attributes.values[0]
    if Cardgame.exists?(game_id: game_id)

      # Add user to game table
      # TODO: Check to see if user is already in a game, if so delete that entry
      old_users = Cardgame.user_ids(game_id)
      Cardgame.where(game_id: game_id).update_all(user_ids: old_users.append(user_id))

      # Add new hand to the database
      # TODO: Check to see if user currently has a hand, if so delete that entry
      hand = Hand.create!({:user_id => user_id, :cards => "3"})
      old_hands = Cardgame.hand_ids(game_id)
      Cardgame.where(game_id: game_id).update_all(hand_ids: old_hands.append(hand.id))

      redirect_to lobby_path(game_id)

    else
      flash[:notice] = 'Game does not exist'
      redirect_to games_path
    end
  end

end
