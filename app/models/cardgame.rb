class Cardgame < ActiveRecord::Base
  serialize :user_ids, JSON

  # Returns user ids in a given game as array
  def self.user_ids(game_id)
    Cardgame.where(game_id: game_id).first[:user_ids]
  end
end

