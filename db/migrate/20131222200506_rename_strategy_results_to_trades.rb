class RenameStrategyResultsToTrades < ActiveRecord::Migration
  def change
    rename_table :strategy_results, :trades
  end
end
