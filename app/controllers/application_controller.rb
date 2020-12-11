class ApplicationController < ActionController::Base
  before_filter :set_current_user, :set_current_game
  after_filter :flash_to_headers
  protect_from_forgery with: :exception

  def set_current_user
    @current_user ||= session[:session_token] && User.where(session_token: session[:session_token])
  end

  def set_current_game
    if @current_user
      if @current_user.select(:current_game).first.attributes.values[1]
        id = @current_user.select(:current_game).first.attributes.values[1]
        @current_game = Cardgame.where(game_id: id, started: true)
        @card_value = {#Back of card
                       0 => "&#127136",
                       #Spades
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
      end
    end
  end

  def flash_to_headers
    return unless request.xhr?
    response.headers['X-Message'] = flash[:notice] unless flash[:notice].blank?
    # repeat for other flash types...

    flash.discard  # don't want the flash to appear when you reload page
  end

  def check_session
    if @current_user
      redirect_to games_path
    end
  end

end
