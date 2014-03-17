require 'rest_client'

class Btce
  include BotUtil

  def self.follow
    url = 'https://btc-e.com/api/3/trades/btc_usd'
    request_interval = 2.0
    limit = 300

    loop do
      begin
        trades = JSON.parse(RestClient.get "#{url}?limit=#{limit}")['btc_usd']
      rescue Exception
        BTCE_FOL_L.error "#{Time.now}: bad request"
        sleep 0.5
        next
      end

      trades = remove_not_appropriate_transactions(trades)
      trades = transactions_from_btce_data(trades)
      save_batch trades

      limit = [[trades.count * 3, 100].max, 2000].min
      request_interval = update_request_interval(limit, request_interval)

      BTCE_FOL_L.info "#{Time.now}: #{trades.count}"
      sleep request_interval
    end
  end

  def self.remove_not_appropriate_transactions(trades)
    last_time_transaction = Transaction.order('time asc').last.try(:time).try(:to_i) || 1
    last_time_trade = trades.first["timestamp"]
    trades.delete_if do |trade|
      trade["timestamp"] == last_time_trade || trade['timestamp'] <= last_time_transaction
    end
    trades
  end

  def self.update_request_interval(limit, request_interval)
    if limit < 500
      [request_interval * 2.0, 30.0].min
    else
      [request_interval / 2.0, 0.01].max
    end
  end

  def self.transactions_from_btce_data(trades)
    trades.map do |trade|
      Transaction.new(time: Time.at(trade["timestamp"]), price: trade["price"], amount: trade["amount"])
    end
  end
end
