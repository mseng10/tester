class CreateDeck < ActiveRecord::Migration
  def change
    create_table 'decks' do |t|
      t.integer 'deck_id'
      t.string 'cards'
    end
  end
end
