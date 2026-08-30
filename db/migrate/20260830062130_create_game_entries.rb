class CreateGameEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :game_entries do |t|
      t.string :GameID

      t.timestamps
    end
  end
end
