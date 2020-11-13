class User < ActiveRecord::Base
  def User::create_user(id_and_password)
    id_and_password[:session_token] = SecureRandom.base64
    create!(id_and_password)
  end
end

