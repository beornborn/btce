class CreateTradeResults < ActiveRecord::Migration
  def change
    create_table :trade_results do |t|
      t.timestamp :time
      t.decimal :usd, scale: 12, precision: 24
      t.decimal :estimate_usd, scale: 12, precision: 24
      t.decimal :btc, scale: 12, precision: 24
      t.decimal :estimate_btc, scale: 12, precision: 24
      t.decimal :price, scale: 12, precision: 24
      t.string :action
      t.references :trade
    end

    add_index :trade_results, :time
  end
end
