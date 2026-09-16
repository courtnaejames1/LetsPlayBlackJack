class AddWinOrLoseToGames < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :win_or_lose, :boolean
  end
end
