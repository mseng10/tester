require 'spec_helper'
require 'rails_helper'
require 'simplecov'
require 'authentication_helpers'
require 'factory_bot'
SimpleCov.start

describe LobbyController do
  include AuthenticationHelpers

  before(:each) do
    session_token = User.find_by(username: "cat").session_token
    request.session[:session_token] = session_token
  end
  after(:each) do
    request.session[:session_token] = nil
  end
  context 'Creating a game' do
    it 'should redirect to the lobby page' do
      test_size = Cardgame.all.size
      redirect_to(new_game_path)
      post :create, { :deck => "1", :shuffle => "on", :jokers => "on", :sink => "1", :show_discards => "on", :hand_size => "4" }
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
end