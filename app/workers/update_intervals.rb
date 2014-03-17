class UpdateIntervals
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options :backtrace => true
  recurrence { minutely(2) }

  def perform
    last_min_time = Minute.order('time asc').last.time
    last_tr_time = Time.at Transaction.order('time asc').last.time
    last_tr_time -= last_tr_time.sec

    MinutesLoader.load_minutes last_min_time, last_tr_time

    %w(minute15 hour hour4 day).each do |interval|
      model = interval.camelize.constantize

      interval_time = MOD_INT[model.to_s]
      last_interval_time = model.order('time asc').last.time
      last_min_time = Minute.order('time asc').last.time

      IntervalsLoader.load_interval interval, last_interval_time, last_min_time
    end

    ichimoku = Indicator.find_by(name: 'ichimoku')
    last_ichimoku_time = ichimoku.ichimokus.order('time asc').last.time
    last_model_time = ichimoku.options[:model].order('time asc').last.time

    IchimokuLoader.load_ichimoku ichimoku, last_ichimoku_time, last_model_time
  end
end
