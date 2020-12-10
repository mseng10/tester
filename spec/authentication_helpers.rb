module AuthenticationHelpers
  def login(user)
    post '/login', params: {:user => {:username => user.username, :password => user.password}}
  end
end