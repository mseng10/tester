class AddStartedColumnToCardgames < ActiveRecord::Migration
  def change
    add_column :cardgames, :started, :boolean
  end
end
