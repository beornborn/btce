class Indicator < ActiveRecord::Base
  include BotUtil
  has_many :ichimokus
  serialize :options

  def self.the_best_ichimoku
    first
  end

  def self.create_ichimokus
    base_params = {model: 'Hour', time_unit: 1.hour, signals: {'senkou_span_b and price' => 'пересечение говорит что делать'}}
    configs = []
    first_mult = 1.5
    while first_mult <= 6
      second_mult = 1.5
      while second_mult <= 6
        start = 1.hours
        while start <= 36.hours
          ap "#{start} #{first_mult} #{second_mult}"
          configs << [start, start * first_mult, start * first_mult * second_mult].map(&:to_i)
          start += 12.hours
        end
        second_mult += 1.2
      end
      first_mult += 1.2
    end

    batch = []
    configs.each do |t|
      ind = Indicator.new options: base_params
      ind.name = "ichimoku_#{t[0]}_#{t[1]}_#{t[2]}"
      ind.options[:short] = t[0]
      ind.options[:medium] = t[1]
      ind.options[:long] = t[2]
      ind.options[:for_sure] = Hour.order('time asc').first.time
      batch << ind
    end

    save_batch batch
  end
end
