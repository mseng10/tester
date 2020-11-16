class Cardgame < ActiveRecord::Base
  serialize :user_ids, JSON
  serialize :hand_ids, JSON
  # TODO: uncomment when cardgame.rb has been updated
  # serialize :deck_ids, JSON
  # serialize :discard_ids, JSON

  # Returns user ids in a given game as array
  def self.user_ids(game_id)
    Cardgame.where(game_id: game_id).first[:user_ids]
  end

  # Returns hand ids in a given game as array
  def self.hand_ids(game_id)
    Cardgame.where(game_id: game_id).first[:hand_ids]
  end
end

