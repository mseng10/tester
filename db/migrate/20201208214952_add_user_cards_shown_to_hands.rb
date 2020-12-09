class AddUserCardsShownToHands < ActiveRecord::Migration
  def change
    add_column :hands, :user_cards_shown, :string
  end
end
