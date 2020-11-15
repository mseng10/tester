require 'spec_helper'
require 'rails_helper'
require 'simplecov'
SimpleCov.start

describe GamesController do
  context 'Creating a index game' do
    it 'should redirect to the index game creation page' do
      post :create
      expect(response).to redirect_to(new_game_path)
    end
  end
end