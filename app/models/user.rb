class User < ActiveRecord::Base
  def User::create_user(id_and_password)
    id_and_password[:session_token] = SecureRandom.base64
    id_and_password[:current_game] = 0
    create!(id_and_password)
  end
end

