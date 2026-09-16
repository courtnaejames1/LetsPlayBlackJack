class AddDecksHandsDeckUserCardsAndDealersCardsToGames < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :decks, :integer
    add_column :games, :hands, :json
    add_column :games, :user_hands, :json
    add_column :games, :dealers_hands, :json
    add_column :games, :deck, :json
  end
end
