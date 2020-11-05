class CreateUser < ActiveRecord::Migration
  def change
    create_table 'users' do |t|
      t.integer 'user_id'
      t.string 'username'
      t.string 'password'
    end
  end
end
