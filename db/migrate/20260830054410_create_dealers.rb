class CreateDealers < ActiveRecord::Migration[8.1]
  def change
    create_table :dealers do |t|
      t.string :DealerName
      t.decimal :HouseEarning

      t.timestamps
    end
  end
end
