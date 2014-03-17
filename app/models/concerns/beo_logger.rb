class BeoLogger
  attr_accessor :logged_date, :trade, :trade_time

  def self.log_sidekiq_error e, ctx_hash
    SKQ_EXC_L.error "#{Time.now} #{e.message}"
    SKQ_EXC_L.error e.backtrace.join("\n")
    SKQ_EXC_L.error ctx_hash.inspect
    SKQ_EXC_L.info (['-'*100]*3).join("\n")
  end

  def self.log_batch batch
    BATCH_L.info "------------------------------- new #{batch.first.class} batch #{Time.now} -------------------------------------"
    BATCH_L.info "batch size: #{batch.size}; begin: #{batch.first.time}; end: #{batch.last.time}"
  end

  def self.info msg
    ap msg
  end

  def initialize trade
    @trade = trade
  end

  def logged_date
    @logged_date ||= trade.current_situation.time.to_date
  end

  def trade_time
    @trade_time ||= trade.end.to_date - @logged_date
  end

  def print_result r
    ap "#{r.time}: usd: #{r.usd}$, btc: #{r.btc}$, estimate_usd: #{r.estimate_usd}$"
  end

  def print_progress
    if trade.current_situation.time.to_date != logged_date
      ap(progress)
      self.logged_date += 1.day
      print_result TradeResult.last
    end
  end

private
  def progress
    (logged_date - trade.begin.to_date).to_f / trade_time.to_f
  end
end
