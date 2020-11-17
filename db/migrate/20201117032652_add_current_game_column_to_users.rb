class AddCurrentGameColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_game, :integer
  end
end
