class CreatePlayerHands < ActiveRecord::Migration[8.1]
  def change
    create_table :player_hands do |t|
      t.integer :DealID
      t.integer :EntryID
      t.decimal :Bet
      t.integer :PlayerHandValue
      t.string :Outcome
      t.string :Payout

      t.timestamps
    end
  end
end
