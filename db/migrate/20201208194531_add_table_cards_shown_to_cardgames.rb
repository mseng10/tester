class AddTableCardsShownToCardgames < ActiveRecord::Migration
  def change
    add_column :cardgames, :table_cards_shown, :string
  end
end
