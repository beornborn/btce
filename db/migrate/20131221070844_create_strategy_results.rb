class CreateStrategyResults < ActiveRecord::Migration
  def change
    create_table :strategy_results do |t|
      t.timestamp :time
      t.decimal :btc, scale: 12, precision: 24
      t.decimal :usd, scale: 12, precision: 24
      t.decimal :estimate_usd, scale: 12, precision: 24
      t.references :strategy
      t.references :exchange
    end
  end
end
