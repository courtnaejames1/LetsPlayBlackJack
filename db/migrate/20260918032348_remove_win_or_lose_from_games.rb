class RemoveWinOrLoseFromGames < ActiveRecord::Migration[8.1]
  def change
    remove_column :games, :win_or_lose, :boolean
  end
end
