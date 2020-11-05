class CreateHand < ActiveRecord::Migration
  def change
    create_table 'hands' do |t|
      t.integer 'hand_id'
      t.integer 'user_id'
      t.string 'cards'
    end
  end
end
