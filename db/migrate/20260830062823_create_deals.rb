class CreateDeals < ActiveRecord::Migration[8.1]
  def change
    create_table :deals do |t|
      t.integer :GameID
      t.integer :RoundNumber
      t.integer :DealerHandValue
      t.timestamp :DealAt

      t.timestamps
    end
  end
end
