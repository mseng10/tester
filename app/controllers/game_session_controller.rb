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
                   12 => "&#127148", #This is a knight of spades
                   13 => "&#127149",
                   14 => "&#127150",
                   #Hearts
                   15 => "&#127153",
                   16 => "&#127154",
                   17 => "&#127155",
                   18 => "&#127156",
                   19 => "&#127157",
                   20 => "&#127158",
                   21 => "&#127159",
                   22 => "&#127160",
                   23 => "&#127161",
                   24 => "&#127162",
                   25 => "&#127163",
                   26 => "&#127164", #This is a knight of hearts
                   27 => "&#127165",
                   28 => "&#127166",
                   #Diamonds
                   29 => "&#127169",
                   30 => "&#127170",
                   31 => "&#127171",
                   32 => "&#127172",
                   33 => "&#127173",
                   34 => "&#127174",
                   35 => "&#127175",
                   36 => "&#127176",
                   37 => "&#127177",
                   38 => "&#127178",
                   39 => "&#127179",
                   40 => "&#127180", #This is a knight of diamonds
                   41 => "&#127181",
                   42 => "&#127182",
                   # Clubs
                   43 => "&#127185",
                   44 => "&#127186",
                   45 => "&#127187",
                   46 => "&#127188",
                   47 => "&#127189",
                   48 => "&#127190",
                   49 => "&#127191",
                   50 => "&#127192",
                   51 => "&#127193",
                   52 => "&#127194",
                   53 => "&#127195",
                   54 => "&#127196", #This is a knight of clubs
                   55 => "&#127197",
                   56 => "&#127198",
                   57 => "&#127169", #This is a red joker
                   58 => "&#127183", #This is a black joker
                   59 => "&#127199", #This is a white joker
    }
    user_hand_card_values = []
    for i in cards
      user_hand_card_values.append(@card_value[i.to_i])
    end

    return user_hand_card_values
  end

  def show
    user_id = @current_user.select(:id).first.attributes.values[0]
    @user_hand_card_values = hash_return(Hand.where(user_id: user_id).select(:cards).first.attributes.values[1].split(','))
    puts(@user_hand_card_values.to_s)

  end
end
