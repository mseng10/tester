require 'spec_helper'
require 'rails_helper'
require 'simplecov'
require 'authentication_helpers'
require 'factory_bot'
SimpleCov.start

describe LobbyController do
  include AuthenticationHelpers

  before(:each) do
    @current_user = FactoryBot.create(:user)
  end
  context 'Creating a game' do
    it 'should redirect to the lobby page' do
      post :create, { :deck => "1", :shuffle => "on", :jokers => "on", :sink => "1", :show_discards => "on", :hand_size => "4" }
      expect(response).to redirect_to(lobby_path)
    end
  end
end