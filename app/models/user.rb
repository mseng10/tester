class User < ActiveRecord::Base
  def User::create_user(id_and_password)
    id_and_password[:session_token] = SecureRandom.base64
    id_and_password[:current_game] = 0
    create!(id_and_password)
  end

  def User::players_in_game(game_id)
    user_ids = Cardgame.find_by(game_id: game_id).user_ids
    usernames = []
    user_ids.each { |user_id| usernames >> User.where(id: user_id).pluck(:username)[0] }
    usernames.join('\n')
  end
end
