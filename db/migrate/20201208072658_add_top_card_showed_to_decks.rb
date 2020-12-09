class AddTopCardShowedToDecks < ActiveRecord::Migration
  def change
    add_column :decks, :top_card_showed, :boolean
  end
end
