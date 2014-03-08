class AutoTrade
  include Sidekiq::Worker
  sidekiq_options :retry => false, :backtrace => true

  def perform(trade_id)
    trade = Trade.find(trade_id)
    trade.auto_trade
  end
end
