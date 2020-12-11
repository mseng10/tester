# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
users = [
    {:user_id => 0, :username => 'Dennis', :password => BCrypt::Password.create('password'), :email => 'email', :current_game => 0},
    {:user_id => 0, :username => 'cat', :password => BCrypt::Password.create('password'), :email => 'meow', :session_token => '/CsEYHnPGIgOOobqDkwAqg==', :current_game => 0}
]

users.each do |user|
  User.create!(user)
end

card_games = [
    {:game_id => 0, :user_ids => '1', :deck_ids => '1', :discard_ids => '2', :hand_ids => '1'},
    {:game_id => 1234, :user_ids => [1], :deck_ids => [1], :discard_ids => [2], :hand_ids => [1], :hand_size => 1},
]

card_games.each do |game|
  Cardgame.create!(game)
end

decks = [
    {:deck_id => 1, :cards => [1,2,3]},
    {:deck_id => 2, :cards => [4,5,6]},
]

decks.each do |deck|
  Deck.create!(deck)
end

hands = [
    {:hand_id => 1, :user_id => 1, :cards => [7,8,9]},
]

hands.each do |hand|
  Hand.create!(hand)
end