class Hand < ActiveRecord::Base

  serialize :cards, JSON
  serialize :user_cards_shown, JSON

  def Hand::create_hand(number,deck_id,user_id)
    cards = Deck.where(id: deck_id).first[:cards]
    hand_id = []
    hands_cards = []
    hands_cards_flips = []
    for card in 1..number do
      if cards.length > 0
        card = cards.pop
        hands_cards.append(card)
        hands_cards_flips.append(false)
      else
        flash[:notice] = 'Cannot create a hand of set size because the deck is out of cards'
      end
    end
    Deck.where(id: deck_id).update_all(cards: cards)
    hand = create!({:user_id => user_id, :cards => hands_cards, :user_cards_shown => hands_cards_flips})
    hand_id.append(hand.id)
    return hand_id
  end

  def self.cards(id)
    Hand.where(id: id).first[:cards]
  end

  def self.user_cards_shown(id)
    Hand.where(user_id: id).first[:user_cards_shown]
  end

end

