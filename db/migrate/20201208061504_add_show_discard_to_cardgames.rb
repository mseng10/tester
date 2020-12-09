class AddShowDiscardToCardgames < ActiveRecord::Migration
  def change
    add_column :cardgames, :show_discard, :boolean
  end
end
