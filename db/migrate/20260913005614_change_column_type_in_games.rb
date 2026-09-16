class ChangeColumnTypeInGames < ActiveRecord::Migration[8.1]
  def change
    change_column :games, :decks, :integer
  end
end
