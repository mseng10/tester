class GameSessionController < ApplicationController

  def hash_return(cards)
    @card_value = {#Spades
                   1 => "&#127137",
                   2 => "&#127138",
                   3 => "&#127139",
                   4 => "&#127140",
                   5 => "&#127141",
                   6 => "&#127142",
                   7 => "&#127143",
                   8 => "&#127144",
                   9 => "&#127145",
                   10 => "&#127146",
                   11 => "&#127147",
                   12 => "&#127149",
                   13 => "&#127150",
                   #Hearts
                   14 => "&#127153",
                   15 => "&#127154",
                   16 => "&#127155",
                   17 => "&#127156",
                   18 => "&#127157",
                   19 => "&#127158",
                   20 => "&#127159",
                   21 => "&#127160",
                   22 => "&#127161",
                   23 => "&#127162",
                   24 => "&#127163",
                   25 => "&#127165",
                   26 => "&#127166",
                   #Diamonds
                   27 => "&#127169",
                   28 => "&#127170",
                   29 => "&#127171",
                   30 => "&#127172",
                   31 => "&#127173",
                   32 => "&#127174",
                   33 => "&#127175",
                   34 => "&#127176",
                   35 => "&#127177",
                   36 => "&#127178",
                   37 => "&#127179",
                   38 => "&#127181",
                   39 => "&#127182",
                   # Clubs
                   40 => "&#127185",
                   41 => "&#127186",
                   42 => "&#127187",
                   43 => "&#127188",
                   44 => "&#127189",
                   45 => "&#127190",
                   46 => "&#127191",
                   47 => "&#127192",
                   48 => "&#127193",
                   49 => "&#127194",
                   50 => "&#127195",
                   51 => "&#127197",
                   52 => "&#127198",
                   53 => "&#127169", #This is a red joker
                   54 => "&#127183", #This is a black joker
                   55 => "&#127148",#This is a knight of spades
                   56 => "&#127164", #This is a knight of hearts
                   57 => "&#127180", #This is a knight of diamonds
                   58 => "&#127196", #This is a knight of clubs

    }
    user_hand_card_values = []
    for i in cards
      if i.to_i == 53 or (i.to_i >=14 and i.to_i <= 39)
        user_hand_card_values.append("R"+@card_value[i.to_i])
      else
        user_hand_card_values.append("B"+@card_value[i.to_i])
      end
    end

    return user_hand_card_values
  end

  def new
    game_id = @current_user.select(:current_game).first.attributes.values[1]
    Cardgame.where(game_id: game_id).update_all(started: true)
    redirect_to game_session_path(game_id)
  end


  #TODO: MAKE THE WEBPAGE REFRESH
  def show
    unless @current_game
      redirect_to games_path
      return
    end
    user_id = @current_user.select(:id).first.attributes.values[0]
    @user_hand_card_values = hash_return(Hand.where(user_id: user_id).select(:cards).first.attributes.values[1].split(','))

    deck_ids = @current_game.deck_ids
    sink_ids = @current_game.discard_ids
    hand_ids = Hand.where(:user_id => user_id).first[:cards]

  end


  def destroy
    game_id = @current_user.select(:current_game).first.attributes.values[1]
    if @current_game
      user_ids = Cardgame.user_ids(game_id)
      User.where(id: user_ids).update_all(current_game: 0)
      Cardgame.where(game_id: game_id).update_all(started: false )
    end
    #TODO: Remove the game from the database.

    # user_ids.each do |id|
    #   User.where(id: id).update_all(current_game: 0)
    # end
    redirect_to games_path
  end
end
