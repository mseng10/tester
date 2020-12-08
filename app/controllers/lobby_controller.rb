class LobbyController < ApplicationController

  def check_if_in_game
    # Verify that a user is not in more than 1 game. If they are, force them to leave the current game.
    user_game_id = @current_user.select(:current_game).first.attributes.values[1]
    if user_game_id != 0
      flash[:notice] = "Please leave your current game before creating a new game."

      # TODO: Redirect to game page that matches the Game ID
      redirect_to lobby_path(user_game_id)
      true
    else
      false
    end
  end

  private :check_if_in_game

  def create
    if check_if_in_game
      return
    end

    # Initialize unique game ID
    game_id = SecureRandom.random_number(9000) + 1000
    user_id = @current_user.select(:id).first.attributes.values[0]

    if Hand.exists?(user_id: user_id)
      Hand.where(user_id: user_id).destroy_all
    end

    # Verifies unique game id
    while Cardgame.exists?(game_id: game_id)
      game_id = SecureRandom.random_number(9000) + 1000
    end

    User.where(id: @current_user.select(:id).first.attributes.values[0]).update_all(current_game: game_id)
    deck_ids = Deck.create_decks(params[:deck], params[:shuffle],params[:jokers])
    discard_ids = Deck.create_sinks(params[:sink])
    hand_ids = Hand.create_hand(params[:hand_size].to_i, deck_ids, user_id)
    show_discard = true

    if params[:show_discards] = "off"
      show_discard= false
    end

    Cardgame.create!({:game_id => game_id, :user_ids => [user_id],
                      :deck_ids => deck_ids, :discard_ids => discard_ids,
                      :hand_ids => hand_ids, :started => false,
                      :hand_size => params[:hand_size].to_i,
                      :table => [],
                      :show_discard => show_discard
                     })

    redirect_to lobby_path(game_id)
  end

  def join
    if check_if_in_game
      return
    end

    game_id = params[:game][:game_id]
    user_id = @current_user.select(:id).first.attributes.values[0]

    # Prevent users from joining a game that has already started
    if Cardgame.where(game_id: game_id).pluck(:started)[0]
      flash[:notice] = 'You cannot join a game that has already started.'
      redirect_to games_path
      return
    end

    if Cardgame.exists?(game_id: game_id)
      # Update the user's current game
      @current_user.update_all(current_game: game_id)

      # Add user to game table
      old_users = Cardgame.user_ids(game_id)
      Cardgame.where(game_id: game_id).update_all(user_ids: old_users.append(user_id))


      if Hand.exists?(user_id: user_id)
        Hand.where(user_id: user_id).destroy_all
      end

      hand = Hand.create_hand(Cardgame.where(game_id: game_id).first[:hand_size], Cardgame.deck_ids(game_id)[0], user_id)
      old_hands = Cardgame.hand_ids(game_id)
      Cardgame.where(game_id: game_id).update_all(hand_ids: old_hands.concat(hand))

      redirect_to lobby_path(game_id)

    else
      flash[:notice] = 'Game does not exist'
      redirect_to games_path
    end
  end

end
