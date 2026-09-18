class AddStatusToGames < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :status, :string, default: "in-progress", null: false
  end
end
