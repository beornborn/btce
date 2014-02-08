class Strategy < ActiveRecord::Base
  has_one :trade

  serialize :options

  def decide_for trade
    send name, trade
  end

  def ichimoku trade
    price = trade.current_situation.close
    time = trade.current_situation.time

    if trade.state == 's'
      min_for_interval = Minute.select('min("low")').by_time(time - options[:look_back_for], time).load.first.min
      trade.close_position if min_for_interval && price < min_for_interval
    elsif trade.state == 'l'
      max_for_interval = Minute.select('max("high")').by_time(time - options[:look_back_for], time).load.first.max
      trade.close_position if max_for_interval && price > max_for_interval
    elsif trade.state == 'out'
      min_for_interval = Minute.select('min("low")').by_time(time - options[:look_back_for], time).load.first.min
      trade.open_position 'l' and return if min_for_interval && price < min_for_interval
      max_for_interval = Minute.select('max("high")').by_time(time - options[:look_back_for], time).load.first.max
      trade.open_position 's' if max_for_interval && price > max_for_interval
    end
  end

  def to_s
    "#{name} #{options}"
  end

  def self.find_or_create_strategy name, options
    Strategy.create_with(options: options).find_or_create_by(name: name, options_hash: options.to_s)
  end
end