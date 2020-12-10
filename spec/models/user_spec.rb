require 'spec_helper'
require 'rails_helper'
require "factory_bot"

describe User do
  describe 'When a user does a successful login' do
    it 'should create a session token and ' do
      test_size = User.all.size
      User.create_user({:username => 'username1', :password => 'password'})
      expect(User.all.size).to equal(test_size+1)
    end
  end
end
