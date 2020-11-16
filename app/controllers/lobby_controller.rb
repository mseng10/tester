class LobbyController < ApplicationController

  def create
    user_id = @current_user.select(:id).first.attributes.values[0]
    @game_id = SecureRandom.random_number(10000)
    @deck = Deck.create!({:cards => "1"})
    @discard = Deck.create!({:cards => "2"})
    @hand = Hand.create!({:user_id => user_id, :cards => "3"})
    # puts %Q{Game ID: #{@game_id}}
    # puts %Q{User ID: #{user_id}}
    # puts %Q{Deck ID: #{@deck.id}}
    # puts %Q{Discard ID: #{@discard.id}}
    # puts %Q{Hand ID: #{@hand.id}}

    Cardgame.create!({ :game_id => @game_id, :user_ids => user_id.to_s + ',',
                       :deck_ids => @deck.id.to_s + ',', :discard_ids => @discard.id.to_s + ',',
                       :hand_ids => @hand.id.to_s + ',', :started => false })
    redirect_to lobby_path(@game_id)
  end

  def join
    @game_id = params[:game][:game_id]
    redirect_to lobby_path(@game_id)
  end

end
