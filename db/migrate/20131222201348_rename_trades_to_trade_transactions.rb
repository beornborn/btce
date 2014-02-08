class RenameTradesToTradeTransactions < ActiveRecord::Migration
  def change
    rename_table :trades, :trade_transactions
  end
end
