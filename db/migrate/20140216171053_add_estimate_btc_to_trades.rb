class AddEstimateBtcToTrades < ActiveRecord::Migration
  def change
    add_column :trades, :estimate_btc, :decimal, scale: 12, precision: 24
  end
end
