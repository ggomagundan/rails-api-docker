class CreateMarketTags < ActiveRecord::Migration[5.0]
  def change
    create_table :market_tags do |t|
      t.integer :market_id
      t.string :tag_name

      t.timestamps
    end
  end
end
