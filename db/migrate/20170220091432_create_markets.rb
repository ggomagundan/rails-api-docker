class CreateMarkets < ActiveRecord::Migration[5.0]
  def change
    create_table :markets do |t|
      t.string :market_name
      t.string :location
      t.integer :view_count, default: 0

      t.timestamps
    end
  end
end
