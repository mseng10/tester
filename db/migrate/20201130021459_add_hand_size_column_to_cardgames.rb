class AddHandSizeColumnToCardgames < ActiveRecord::Migration
  def change
    add_column :cardgames, :hand_size, :integer
  end
end
