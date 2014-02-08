class Strategy < ActiveRecord::Base
  has_many :trades

  serialize :options
  attr_accessor :name, :step, :look_back_for
  INTERVALS = [3.minute, 5.minute, 15.minute, 30.minute, 1.hour, 2.hour, 4.hour, 6.hour, 12.hour, 1.day, 3.day]
  
  def initialize name, look_back_for
    @name = name
    @look_back_for = look_back_for
    @step = case name
            when 'cosa_nostra'
              1.minutes
            end
  end

  def decide_for trade
    send name, trade
  end

  def cosa_nostra trade
    price = trade.current_situation.enter
    time = trade.current_situation.time

    if trade.btc == 0
      min_for_interval = Minute.select('min("min")').by_time(time-look_back_for, time).load.first.min
      trade.buy_for(trade.usd) if price < min_for_interval
    end

    if trade.usd == 0
      max_for_day = Minute.select('max("max")').by_time(time-look_back_for, time).load.first.max
      trade.sell(trade.btc) if price > max_for_day
    end
  end

  def cosa_nostra2 trade
    price = trade.current_situation.enter
    time = trade.current_situation.time

    if trade.btc == 0
      min_for_interval = Minute.select('min("min")').by_time(time-look_back_for, time).load.first.min
      trade.buy_for(trade.usd) if price < min_for_interval
    end

    if trade.usd == 0
      max_for_day = Minute.select('max("max")').by_time(time-look_back_for, time).load.first.max
      trade.sell(trade.btc) if price > max_for_day
    end
  end

  def to_s
    "#{name}_#{look_back_for}"
  end
end
