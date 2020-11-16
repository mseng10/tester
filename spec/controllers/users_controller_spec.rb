require 'spec_helper'
require 'rails_helper'
require 'simplecov'
SimpleCov.start

describe UsersController do
  context 'Creating a new user' do
    it 'should redirect to the Login Page' do
      post :create, {:user => {:username => 'username1', :password => 'password'}}
      expect(response).to redirect_to(login_path)
    end
    it 'should add a user to the database' do
      test_size = User.all.size
      post :create, {:user => {:username => 'username1', :password => 'password'}}
      expect(User.all.size).to equal(test_size+1)
    end
    it 'should redirect to the Sign Up Page if the username already taken' do
      post :create, {:user => {:username => 'username1', :password => 'password'}}
      post :create, {:user => {:username => 'username1', :password => 'password'}}
      expect(response).to redirect_to(new_user_path)
    end
    it 'should not add a user to the database' do
      test_size = User.all.size
      post :create, {:user => {:username => 'username1', :password => 'password'}}
      post :create, {:user => {:username => 'username1', :password => 'password'}}
      expect(User.all.size).to equal(test_size+1)
    end
  end
end