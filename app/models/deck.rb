class Deck < ActiveRecord::Base

  def Deck::create_decks(number,shuffled,jokers)
    deck_ids = []
    final_value = 52
    if jokers.to_s == "on"
      final_value = 54
    end
    for deck in 1..number.to_i
      cards = []
      for card in 1..final_value do
        cards.append(card.to_s)
      end
      if shuffled.to_s == "on"
        curr_deck = create!({:cards => cards.shuffle.join(',')})
      else
        curr_deck = create!({:cards => cards.join(',')})
      end
      deck_ids.append(curr_deck.id)
    end
    return deck_ids
  end

  def Deck::create_sinks(number)
    deck_ids = []
    for deck in 1..number.to_i
      curr_deck = create!({:cards => ""})
      deck_ids.append(curr_deck.id)
    end
    return deck_ids
  end
end

