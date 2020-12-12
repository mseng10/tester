require 'pusher'
class Cardgame < ActiveRecord::Base
  serialize :user_ids, JSON
  serialize :hand_ids, JSON
  serialize :deck_ids, JSON
  serialize :discard_ids, JSON
  serialize :table, JSON
  serialize :table_cards_shown, JSON

  # Returns user ids in a given game as array
  def self.user_ids(game_id)
    Cardgame.where(game_id: game_id).first[:user_ids]
  end

  # Returns hand ids in a given game as array
  def self.hand_ids(game_id)
    Cardgame.where(game_id: game_id).first[:hand_ids]
  end

  def self.deck_ids(game_id)
    Cardgame.where(game_id: game_id).first[:deck_ids]
  end

  def self.discard_ids(game_id)
    Cardgame.where(game_id: game_id).first[:discard_ids]
  end

  def self.table(game_id)
    Cardgame.where(game_id: game_id).first[:table]
  end

  def self.table_cards_shown(game_id)
    Cardgame.where(game_id: game_id).first[:table_cards_shown]
  end

  def notify_pusher(game_id)
    Pusher.trigger('update_'+game_id.to_s, 'up', "")
  end

  def increment_users_pusher(usernames,game_id)
    Pusher.trigger('update_users_'+game_id, 'up_users', usernames.to_s)
  end
end

