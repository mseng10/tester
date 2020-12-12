class AddMessagesToCardgames < ActiveRecord::Migration
  def change
    add_column :cardgames, :messages, :string
  end
end
