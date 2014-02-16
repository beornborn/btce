class Trade < ActiveRecord::Base
  has_many :trade_results, dependent: :destroy
  belongs_to :exchange
  belongs_to :strategy
  attr_accessor :logger
  serialize :options

  def to_s
    options[:description]
  end

  def last_tr
    trade_results.order('time asc').last
  end

  def model
    options[:model_name].constantize
  end

  def current_situation
    options[:model_name].constantize.find_by(time: self.end)
  end

  def buy_for amount
    self.usd -= amount
    self.btc += (amount / current_situation.close) * (1 - exchange.options[:comission])
    self.estimate_usd = self.usd + (self.btc * current_situation.close) * (1 - exchange.options[:comission])
    self.profit_rate = (estimate_usd / initial_usd).round(2)
    save!
  end

  def sell amount
    self.btc -= amount
    self.usd += (amount * current_situation.close) * (1 - exchange.options[:comission])
    self.estimate_usd = self.usd + (self.btc * current_situation.close) * (1 - exchange.options[:comission])
    self.profit_rate = (estimate_usd / initial_usd).round(2)
    save!
  end

  def store_result action
    TradeResult.create(time: current_situation.time, usd: usd, estimate_usd: estimate_usd, btc: btc, trade: self, action: action)
  end
end
