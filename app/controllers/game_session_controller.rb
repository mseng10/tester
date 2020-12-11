class GameSessionController < ApplicationController

  def hash_return(cards,shown)
    @card_valu = {#Back of card
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
    user_hand_card_values = {}
    cards.each do |i|
      if shown
        if i == 53 or (i >=14 and i <= 39)
          user_hand_card_values[i] = "R"+@card_valu[i]
        else
          user_hand_card_values[i]= "B"+@card_valu[i]
        end
      else
        user_hand_card_values[i]= "B"+@card_valu[0]
      end
    end

    return user_hand_card_values
  end

  def index
    unless @current_game.first
      redirect_to games_path
    end
  end

  def new
    game_id = @current_user.select(:current_game).first.attributes.values[1]
    Cardgame.where(game_id: game_id).update_all(started: true)
    redirect_to game_session_path(game_id)
  end

  #TODO: MAKE THE WEBPAGE REFRESH
  def show
    unless @current_game.first
      redirect_to games_path
      return
    end
    #GOOD
    @sinks = @current_game.select(:discard_ids).first.attributes.values[1]
    @sinkHashes = []
    @sinks.each do |sink|
      sink_top_card = Deck.where(id: sink).select(:top_card_showed).first.attributes["top_card_showed"]
      hash = {}
      hash[:id] = sink
      list = Deck.where(id: sink).pluck(:cards)[0]
      if list.size > 0
        hash = hash.merge(hash_return([Deck.where(id: sink).pluck(:cards)[0].last],sink_top_card))
      end
      @sinkHashes.append(hash)
    end

    #GOOD
    @decks = @current_game.select(:deck_ids).first.attributes.values[1]
    @deckHashes = []
    @decks.each do |deck|
        deck_top_card = Deck.where(id: deck).select(:top_card_showed).first.attributes["top_card_showed"]
        hash = {}
        hash[:id] = deck
        list = Deck.where(id: deck).pluck(:cards)[0]
        if list.size > 0
          hash = hash.merge(hash_return([Deck.where(id: deck).pluck(:cards)[0].last],deck_top_card))
        end
        @deckHashes.append(hash)
    end

    user_id = @current_user.select(:id).first.attributes.values[0]
    @user_hand_card_value = Hand.where(user_id: user_id).select(:cards).first.attributes.values[1]
    count = 0
    users_hand_cards_flipped = Hand.user_cards_shown(user_id)
    @new_user_hash = {}
    @user_hand_card_value.each do |card|
      value = @card_value[card.to_i]
      if card.to_i == 53 or (card.to_i >=14 and card.to_i <= 39)
        value = "R"+value
      else
        value = "B"+value
      end
      if users_hand_cards_flipped[count] == true
        value = "F" + value
      end
      @new_user_hash[count] = value
      count = count + 1
    end
    @user_hand_card_values = @new_user_hash


    @user_id_list = @current_game.first.user_ids
    @user_cards_hash = {}
    @user_id_list.each do |other_user_id|
      count = 0
      username = User.where(id: other_user_id).pluck(:username)[0]
      card_ids = Hand.where(user_id: other_user_id).select(:cards).first.attributes.values[1]
      flipped_other = Hand.user_cards_shown(other_user_id)
      temp_hash = {}
      card_ids.each do |card|
        value = @card_value[card.to_i]
        if flipped_other[count] == false
          value = "B&#127136"
        else
          if card.to_i == 53 or (card.to_i >=14 and card.to_i <= 39)
            value = "R"+value
          else
            value = "B"+value
          end
        end
        temp_hash[count] = value
        count = count + 1
      end
      @user_cards_hash[other_user_id] = { :username => username, :cards => temp_hash }
    end

    #table
    table_cards = @current_game.pluck(:table)[0]
    count = 0
    table_cards_boolean = @current_game.pluck(:table_cards_shown)[0]
    @new_table_hash = {}
    table_cards.each do|table|
      value = @card_value[table.to_i]
      if table_cards_boolean[count] == false
        value = "B&#127136"
      elsif table.to_i == 53 or (table.to_i >=14 and table.to_i <= 39)
        value = "R"+value
      else
        value = "B"+value
      end
      @new_table_hash[count] = value
      count = count + 1
    end
    @table = @new_table_hash

    @deck_sizes = {}
    @decks.each do |deck|
      @deck_sizes[deck] = Deck.cards(deck).size
    end
    @sink_sizes = {}
    @sinks.each do |sink|
      @sink_sizes[sink] = Deck.cards(sink).size
    end
  end


  def destroy
    # Check that the user is still in a game
    if @current_user.select(:current_game).first.attributes.values[1] != 0
      game_id = @current_user.select(:current_game).first.attributes.values[1]
      row_id = @current_game.pluck(:id)
      deck_ids = Cardgame.where(id: row_id).pluck(:deck_ids)[0].concat(Cardgame.where(id: row_id).pluck(:discard_ids)[0])
      hand_ids = Cardgame.where(id: row_id).pluck(:hand_ids)[0]

      if @current_game.first
        user_ids = Cardgame.user_ids(game_id)
        User.where(id: user_ids).update_all(current_game: 0)
        Cardgame.where(game_id: game_id).update_all(started: false )
      end

      Cardgame.delete(row_id)
      deck_ids.each do |id|
        Deck.delete(id)
      end
      hand_ids.each do |id|
        Hand.delete(id)
      end

      user_ids.each do |id|
        User.where(id: id).update_all(current_game: 0)
      end
    end
    redirect_to games_path
    flash[:notice] = "One of the user ended the game"
  end

  def update
    # TODO: logic to move card from one user to the other
    # Need to fix the card from unicode to id
    # Location 0 is the function. each one after that is the params
    user_id = @current_user.select(:id).first.attributes.values[0]
    game_id = @current_user.select(:current_game).first.attributes.values[1]
    apiHelper = ApiHelper.new(request.original_url)
    game_id = @current_user.select(:current_game).first.attributes.values[1]

    if apiHelper.function == 'moveCard'

      current_user_cards =Hand.where(user_id: user_id).select(:cards).first.attributes.values[1]
      value = current_user_cards[apiHelper.parameters['card'].to_i]
      current_user_cards.slice!(apiHelper.parameters['card'].to_i)
      current_user_booleans = Hand.user_cards_shown(user_id)
      current_user_booleans.slice!(apiHelper.parameters['card'].to_i)
      Hand.where(user_id: user_id).update_all(cards: current_user_cards, user_cards_shown: current_user_booleans)

      # Move card to table
      # #good
      if apiHelper.parameters['dest'] == 'table'
        table = @current_game.pluck(:table)[0]
        table.append(value)
        Cardgame.where(game_id: game_id).update_all(table: table)
        table_booleans = @current_game.pluck(:table_cards_shown)[0]
        table_booleans = table_booleans.append(true)
        Cardgame.where(game_id: game_id).update_all(table_cards_shown: table_booleans)

      # Move card to sink
      # #good
      elsif apiHelper.parameters['dest'].include?('sink')
        sinkID = apiHelper.parameters['dest'].gsub('sink_', '')
        current_cards_in_sink = Deck.where(id: sinkID).select(:cards).first.attributes.values[1]
        current_cards_in_sink.append(value)
        Deck.where(id: sinkID).update_all(cards: current_cards_in_sink, top_card_showed: true)

      # Move Card to other users hand
      # #Good
      else
        other_user_id = User.where(username: apiHelper.parameters['dest']).select(:id).first.attributes.values[0]
        other_user_cards =Hand.where(user_id: other_user_id).select(:cards).first.attributes.values[1]
        other_user_cards.append(value)
        other_user_booleans = Hand.user_cards_shown(other_user_id)
        other_user_booleans.append(false)
        Hand.where(user_id: other_user_id).update_all(cards: other_user_cards, user_cards_shown: other_user_booleans)
      end

    #GOOOD
    elsif apiHelper.function == 'moveCardDraw'
      #GOOD
      current_cards_from_draw = Deck.where(id: apiHelper.parameters['source']).pluck(:cards)[0]
      current_picked_card = current_cards_from_draw.last
      current_cards_from_draw.pop
      Deck.where(id: apiHelper.parameters['source']).update_all(cards: current_cards_from_draw)

      #GOOD
      if apiHelper.parameters['dest'] == 'table'
        table = @current_game.pluck(:table)[0]
        table.append(current_picked_card)
        Cardgame.where(game_id: game_id).update_all(table: table)
        table_booleans = @current_game.pluck(:table_cards_shown)[0]
        table_booleans = table_booleans.append(true)
        Cardgame.where(game_id: game_id).update_all(table_cards_shown: table_booleans)

      #GOOD
      elsif apiHelper.parameters['dest'].include?('sink')
        sinkID = apiHelper.parameters['dest'].gsub('sink_', '')
        current_cards_in_sink = Deck.where(id: sinkID).select(:cards).first.attributes.values[1]
        current_cards_in_sink.append(current_picked_card)
        Deck.where(id: sinkID).update_all(cards: current_cards_in_sink)

      #IDK
      elsif apiHelper.parameters['dest'].include?('draw')
        draw_id = apiHelper.parameters['dest'].gsub('draw_', '')
        current_cards_in_draw = Deck.where(id: draw_id).select(:cards).first.attributes.values[1]
        current_cards_in_draw.append(current_picked_card)
        Deck.where(id: draw_id).update_all(cards: current_cards_in_draw)

        #GOOD
      else
        target_user_id = User.where(username: apiHelper.parameters['dest']).select(:id).first.attributes.values[0]
        target_user_cards = Hand.where(user_id: target_user_id).select(:cards).first.attributes.values[1]
        target_user_cards.append(current_picked_card)
        Hand.where(user_id: target_user_id).update_all(cards: target_user_cards)
      end
      #GOOD
      decks = @current_game.select(:deck_ids).first.attributes.values[1]
      if decks.include? apiHelper.parameters['source'].to_i
        Deck.where(:id => apiHelper.parameters['source']).update_all(:top_card_showed => false)
      else
        boolean = @current_game.select(:show_discard).first.attributes["show_discard"]
        Deck.where(:id => apiHelper.parameters['source']).update_all(:top_card_showed => boolean)
      end

    #good
    elsif apiHelper.function == 'moveCardTable'
      current_table_cards = Cardgame.table(game_id)
      current_table_cards_flipped = Cardgame.table_cards_shown(game_id)

      card_id_helper = current_table_cards[apiHelper.parameters['card'].to_i]
      current_table_cards.slice!(apiHelper.parameters['card'].to_i)
      current_table_cards_flipped.slice!(apiHelper.parameters['card'].to_i)
      Cardgame.where(game_id: game_id).update_all(table: current_table_cards, table_cards_shown: current_table_cards_flipped)

      #good
      if apiHelper.parameters['dest'].include?('sink')
        sink_id = apiHelper.parameters['dest'].gsub('sink_', '')
        current_cards_in_sink = Deck.where(id: sink_id).select(:cards).first.attributes.values[1]
        current_cards_in_sink.append(card_id_helper)
        Deck.where(id: sink_id).update_all(cards: current_cards_in_sink)
        Deck.where(:id => sink_id).update_all(:top_card_showed => @current_game.select(:show_discard).first.attributes["show_discard"])

      #good
      else
        user_id = User.where(username: apiHelper.parameters['dest']).select(:id).first.attributes.values[0]
        current_user_cards = Hand.where(user_id: user_id).select(:cards).pluck(:cards)[0]
        current_user_cards.append(card_id_helper)
        current_user_cards_shown = Hand.where(user_id: user_id).select(:user_cards_shown).pluck(:user_cards_shown)[0]
        current_user_cards_shown.append(false)
        Hand.where(user_id: user_id).update_all(cards: current_user_cards)
        Hand.where(user_id: user_id).update_all(user_cards_shown: current_user_cards_shown)
      end

    #If the user elects to flip a card
    elsif apiHelper.function == 'flipCard'

      #flips top card of draw card pile
      if apiHelper.parameters['id'].include? 'draw'
        id = apiHelper.parameters['id'].gsub("draw", "")
        opposite = !Deck.where(id: id).select(:top_card_showed).first.attributes["top_card_showed"]
        Deck.where(:id => id).update_all(:top_card_showed => opposite)

      #flips top card of discard card pile
      elsif apiHelper.parameters['id'].include? 'sink'
        id = apiHelper.parameters['id'].gsub("sink", "")
        opposite = !Deck.where(id: id).select(:top_card_showed).first.attributes["top_card_showed"]
        Deck.where(:id => id).update_all(:top_card_showed => opposite)

      #flips selected card on table
      elsif apiHelper.parameters['id'].include? 'table'
        id = apiHelper.parameters['id'].gsub("table", "")
        table_cards_boolean = @current_game.pluck(:table_cards_shown)[0]
        table_cards_boolean[id.to_i] = !table_cards_boolean[id.to_i]
        Cardgame.where(game_id: game_id).update_all(table_cards_shown: table_cards_boolean)

      #flips user's card
      elsif apiHelper.parameters['id'].include? 'user'
        id = apiHelper.parameters['id'].gsub("user", "")
        table_cards_boolean = Hand.where(user_id: user_id).select(:cards).pluck(:user_cards_shown)[0]
        table_cards_boolean[apiHelper.parameters['index'].to_i] = !table_cards_boolean[apiHelper.parameters['index'].to_i]
        Hand.where(user_id: user_id).update_all(user_cards_shown: table_cards_boolean)
      end

    elsif apiHelper.function == 'leaveGame'
      current_user_cards = Hand.where(user_id: user_id).select(:cards).first.attributes.values[1]

      if current_user_cards.size == 0
        user_ids = Cardgame.user_ids(game_id)
        hand_ids = Cardgame.hand_ids(game_id)
        hand_id = Hand.where(user_id: user_id).select(:id).first.attributes.values[0]

        user_ids.delete(user_id)
        hand_ids.delete(hand_id)

        Cardgame.where(id: @current_game.pluck(:id)).update_all(user_ids: user_ids, hand_ids: hand_ids)
        Hand.delete(hand_id)
        User.where(id: user_id).update_all(current_game: 0)
        redirect_to games_path
        return
      else
        flash[:notice] = 'Please discard the cards in your hand to leave the game'
      end

    elsif apiHelper.function == 'resetGame'
      jokers = @current_game.select(:jokers).first.attributes["jokers"]
      shuffle = @current_game.select(:shuffle).first.attributes["shuffle"]
      hand_size = @current_game.select(:hand_size).first.attributes["hand_size"]
      show_discard = @current_game.select(:show_discard).first.attributes["show_discard"]

      row_id = @current_game.pluck(:id)
      deck_ids = Cardgame.where(id: row_id).pluck(:deck_ids)[0]
      sink_ids = Cardgame.where(id: row_id).pluck(:discard_ids)[0]
      hand_ids = Cardgame.where(id: row_id).pluck(:hand_ids)[0]
      user_ids = Cardgame.where(id: row_id).pluck(:user_ids)[0]

      deck_ids.each do |id|
        Deck.delete(id)
      end
      sink_ids.each do |id|
        Deck.delete(id)
      end
      hand_ids.each do |id|
        Hand.delete(id)
      end

      jokers_string = "off"
      if jokers
        jokers_string = "on"
      end
      shuffle_string = "off"
      if shuffle
        shuffle_string = "on"
      end
      show_discard_string = "off"
      if show_discard
        show_discard_string= "on"
      end

      deck_ids = Deck.create_decks(deck_ids.size, shuffle_string,jokers_string)
      discard_ids = Deck.create_sinks(sink_ids.size,show_discard_string)

      hand_ids = []
      user_ids.each do |user|
        hand_ids.append(Hand.create_hand(hand_size, deck_ids[0], user)[0])
      end

      Cardgame.where(id: @current_game.pluck(:id)).update_all(deck_ids: deck_ids, discard_ids: discard_ids, hand_ids: hand_ids, table: [], table_cards_shown: [])

    elsif apiHelper.function == 'shuffle'
      deck_id = apiHelper.parameters['deck'].to_i
      deck = Deck.where(id: deck_id).pluck(:cards)[0]
      deck = deck.shuffle
      Deck.where(id: deck_id).update_all(cards: deck)
    end

    redirect_to game_session_path(game_id)
  end
end

class ApiHelper
  attr_reader :function,:parameters
  def initialize(url)
    data = url.split(/([^.]+$)/)[1].split('&')
    @function = data[0].split('=')[1]
    @parameters = {}
    data.each_with_index do |elem, i|
      if i != 0
        info = elem.split('=')
        @parameters[info[0]] = info[1]
      end
    end
  end
end


