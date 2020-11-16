require 'spec_helper'
require 'rails_helper'
require 'simplecov'
SimpleCov.start

describe SessionsController do
  context 'Creating a new login session' do
    it 'should redirect to the login page if the username is empty' do
      post :create, {:user => {:username => '', :password => 'password'}}
      expect(response).to redirect_to(login_path)
    end
    it 'should redirect to the login page if the username is correct but the password is not' do
      post :create, {:user => {:username => 'Dennis', :password => 'pass'}}
      expect(response).to redirect_to(login_path)
    end
    it 'should redirect to the games page if the username and password are correct' do
      post :create, {:user => {:username => 'Dennis', :password => 'password'}}
      expect(response).to redirect_to('/games')
    end
    it 'should logout when I select the logout button' do
      post :create, {:user => {:username => 'Dennis', :password => 'password'}}
      post :destroy, {:user => {:username => 'Dennis', :password => 'password'}}
      expect(response).to redirect_to(login_path)
    end
    it 'should logout when I leave the browser' do
      post :new
      expect(response).to have_http_status(200)
    end
  end
end