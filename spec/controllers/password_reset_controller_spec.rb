require 'spec_helper'
require 'rails_helper'
require 'simplecov'
SimpleCov.start

describe PasswordResetController do
  context 'Resetting the password' do
    it 'should change the password if done successfully' do
      post :create, {:user => {:email => 'meow', :password => '1234567!', :password2 => '1234567!'}}
      expect(BCrypt::Password.new(User.where(username: 'cat').pluck(:password)[0])).to eq('1234567!')
    end
    it 'should fail if the email does not exist' do
      post :create, {:user => {:email => 'woof', :password => '1234567!', :password2 => '1234567!'}}
      expect(BCrypt::Password.new(User.where(username: 'cat').pluck(:password)[0])).to_not eq('1234567!')
    end
  end
end