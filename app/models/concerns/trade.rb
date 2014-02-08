class Trade < ActiveRecord::Base
  has_many :trade_results
  belongs_to :exchange
  belongs_to :strategy

  attr_accessor :usd, :btc, :estimate_usd, :interval, :current_situation


  def initialize usd, exchange, strategy, interval
    @usd = usd
    @btc = 0
    @estimate_usd = usd
    @exchange = Exchange.find_by(name: exchange)
    @strategy = strategy
    @interval = interval
    @current_situation = nil
  end

  def self.last_usd strategy
    where(strategy: strategy).order('time asc').last.estimate_usd
  end

  def self.run_for_intervals usd, exchange, strategy_name, interval
    Strategy::INTERVALS.each do |look_back_for|
      strategy = Strategy.new strategy_name, look_back_for
      Trade.new(usd, exchange, strategy, interval).run
    end 
  end

  def run
    ActiveRecord::Base.logger.level = 1
    StrategyResult.where(strategy: strategy.to_s).destroy_all
    self.current_situation = Minute.where('time > ?', interval[:begin]).order('time asc').first
    @iter_date = current_situation.time.to_date
    log_result

    while current_situation && current_situation.time <= interval[:end]
      strategy.decide_for self
      if @iter_date != current_situation.time.to_date
        ap "#{@iter_date}" 
        @iter_date+=1.day
      end 
      self.current_situation = Minute.find_by(time: current_situation.time += strategy.step)
    end
  end

  def buy_for amount
    self.usd -= amount
    self.btc += ((amount / current_situation.enter) * (1 - exchange.comission)).round(8)
    self.estimate_usd = (btc * current_situation.enter * (1 - exchange.comission) + usd).round(8)

    log_result
  end

  def sell amount
    self.usd += (amount * current_situation.enter * (1 - exchange.comission)).round(8)
    self.btc -= amount
    self.estimate_usd = (btc * current_situation.enter * (1 - exchange.comission) + usd).round(8)

    log_result
  end

  def log_result
    StrategyResult.create(time: current_situation.time, btc: btc, usd: usd, estimate_usd: estimate_usd, strategy: strategy.to_s)
    ap "#{current_situation.time}: usd: #{usd}$, estimate_usd: #{estimate_usd}$, btc: #{btc}" 
  end

  def self.ago time
    last = Minute.last.time
    {begin: last - time, end: last}
  end
end