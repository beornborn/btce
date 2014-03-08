class UpdateOther
  include Sidekiq::Worker
  sidekiq_options :retry => false, :backtrace => true

  def perform
    begin
      loop do
        %w(minute3 minute5 minute15 minute30 hour hour2 hour4 hour6 hour12 day day3 day7).each do |interval|
          model = interval.camelize.constantize

          interval_time = MOD_INT[model.to_s]
          last_interval_time = model.order('time asc').last.time
          last_min_time = Minute.order('time asc').last.time

          IntervalsLoader.load_interval interval, last_interval_time, last_min_time, SULO3
        end

        # Hour
        # ichimoku = Indicator.find_by(name: 'ichimoku')
        # last_ichimoku_time = ichimoku.ichimokus.order('time asc').last.time
        # last_model_time = ichimoku.options[:model].order('time asc').last.time

        # IchimokuLoader.load_ichimoku ichimoku, last_ichimoku_time, last_model_time, SULO5

        sleep 2.minute
      end
    rescue Exception => e
      SULO10.error "#{Time.now} #{e.message}"
      SULO10.error e.backtrace.join("\n")
      SULO10.info (['-'*100]*5).join("\n")
    end
  end
end
