class Trade < ActiveRecord::Base
  has_many :trade_results
  belongs_to :exchange
  belongs_to :strategy
  attr_accessor :logger
  attr_accessor :usd, :estimate_usd, :btc, :current_situation, :action
  serialize :options
  
  def self.try_to_run
    look_backs = [15.minute, 2.hour, 8.hour, 1.day, 7.day, 1.month]
    leverages = [0.001, 0.005, 0.01, 0.05, 0.1]

    # look_backs.each do |look_back|
    #   leverages.each do |leverage|
    #     next if look_back == 15.minute && ([0.001, 0.005, 0.01].include? leverage)
        strategy = Strategy.find_or_create_strategy 'ichimoku', {}
        exchange = Exchange.find_or_create_by name: 'btce'
        Trade.where(strategy_id: strategy.id).destroy_all
        begin_t = Date.new(2013, 10, 1)
        end_t = Date.new(2014, 1, 1)
        trade = Trade.create(initial_usd: 1000, begin: begin_t, end: end_t, exchange: exchange, strategy: strategy)
        trade.run
      # end
    # end
  end

  def calculate_profit_rate
    result_usd = self.trade_results.order('time asc').last.estimate_usd
    (result_usd / initial_usd).round(2)
  end

  def init_trade
    ActiveRecord::Base.logger.level = 1
    self.logger = BeoLogger.new self
    
    trade_results.destroy_all
    
    self.current_situation = Minute.where('time > ?', self.begin).order('time asc').first

    self.usd = self.initial_usd
    self.estimate_usd = self.usd
    self.btc = 0

    store_result
  end

  def to_s
    options[:description]
  end

  def run
    init_trade

    while current_situation && current_situation.time <= self.end
      strategy.decide_for self
      calculate_situation_result

      logger.print_progress
      
      store_result
      self.current_situation = Minute.where('time >= ?', current_situation.time + strategy.options[:trade_step]).order('time asc').limit(1).first
    end

    pr = calculate_profit_rate
    self.update_attribute(:profit_rate, pr < 0 ? 0 : pr)
  end

  def buy_for amount
    self.usd -= amount 
    self.btc += (amount / current_situation.close) * (1 - exchange.options[:comission])
  end

  def sell amount
    self.btc -= amount 
    self.usd += (amount * current_situation.close) * (1 - exchange.options[:comission])
  end

  def calculate_situation_result
    self.estimate_usd = self.usd + (self.btc * current_situation.close) * (1 - exchange.options[:comission])
  end

  def store_result
    TradeResult.create(time: current_situation.time, usd: usd, estimate_usd: estimate_usd, btc: btc, trade: self, action: self.action)
    self.action = nil
  end
end