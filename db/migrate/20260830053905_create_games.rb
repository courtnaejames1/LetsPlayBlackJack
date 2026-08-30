class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.string :GameName
      t.integer :DealersID
      t.decimal :BetMinimum
      t.boolean :InPlay

      t.timestamps
    end
  end
end
