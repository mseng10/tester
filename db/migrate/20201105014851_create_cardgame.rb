class CreateCardgame < ActiveRecord::Migration
  def change
    create_table 'cardgames' do |t|
      t.integer 'game_id'
      t.string 'user_ids'
      t.string 'deck_ids'
      t.string 'discard_ids'
      t.string 'hand_ids'
    end
  end
end
