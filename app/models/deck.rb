class Deck < ActiveRecord::Base

  def Deck::create_decks(number,shuffled)
    deck_ids = []
    for deck in 1..number.to_i
      cards = []
      for card in 1..59 do
        cards.append(card.to_s)
      end
      if shuffled.to_s == "on"
        curr_deck = create!({:cards => cards.shuffle})
      else
        curr_deck = create!({:cards => cards})
      end
      deck_ids.append(curr_deck.id)
    end
    return deck_ids
  end

  def Deck::create_sinks(number)
    deck_ids = []
    for deck in 1..number.to_i
      curr_deck = create!({:cards => []})
      deck_ids.append(curr_deck.id)
    end
    return deck_ids
  end
end

