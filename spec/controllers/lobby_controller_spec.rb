require 'spec_helper'
require 'rails_helper'
require 'simplecov'
SimpleCov.start

describe LobbyController do

  before do
    session_token = User.find_by(username: "cat").session_token
    request.session[:session_token] = session_token
  end
  context 'Creating a game' do
    it 'should create a game in the database' do
      test_size = Cardgame.all.size
      redirect_to(new_game_path)
      post :create, { :deck => "1", :shuffle => "on", :jokers => "on", :sink => "1", :show_discards => "on", :hand_size => "1" }
      expect(Cardgame.all.size).to equal(test_size + 1)
    end
    it 'should create a game in the database with no jokers and showing discards off' do
      test_size = Cardgame.all.size
      redirect_to(new_game_path)
      post :create, { :deck => "1", :shuffle => "off", :jokers => "on", :sink => "1", :show_discards => "off", :hand_size => "1" }
      expect(Cardgame.all.size).to equal(test_size + 1)
    end
  end
  context 'Joining a game' do
    it 'should redirect to the lobby page' do
      redirect_to(games_path)
      get :join, { :game => { :game_id => 1234 }}
      expect(response.body).to include("http://test.host/lobby/1234")
    end
  end
  after do
    request.session[:session_token] = nil
  end
end