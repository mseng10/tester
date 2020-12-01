class Hand < ActiveRecord::Base

  def Hand::create_hand(number,deck_id,user_id)
    cards = Deck.where(id: deck_id).first[:cards].split(',')
    hand_id = []
    hands_cards = []
    for card in 1..number do
      if cards.length > 0
        card = cards.pop
        hands_cards.append(card)
      else
        flash[:notice] = 'Cannot create a hand of set size because the deck is out of cards'
      end
    end
    Deck.where(id: deck_id).update_all(cards: cards.join(','))
    hand = create!({:user_id => user_id, :cards => hands_cards.join(',')})
    hand_id.append(hand.id)
    return hand_id
  end

end

