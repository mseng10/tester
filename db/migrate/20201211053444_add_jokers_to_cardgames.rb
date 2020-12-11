class AddJokersToCardgames < ActiveRecord::Migration
  def change
    add_column :cardgames, :jokers, :boolean
  end
end
