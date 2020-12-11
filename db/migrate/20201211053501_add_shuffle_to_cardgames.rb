class AddShuffleToCardgames < ActiveRecord::Migration
  def change
    add_column :cardgames, :shuffle, :boolean
  end
end
