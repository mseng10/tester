class AddTableColumnToCardgames < ActiveRecord::Migration
  def change
    add_column :cardgames, :table, :string
  end
end
