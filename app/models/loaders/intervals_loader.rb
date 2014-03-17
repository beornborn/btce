class IntervalsLoader < DataLoader
  def self.load_interval_for_sure set = 'all'
    set = %w(minute15 hour hour4 day) if set == 'all'
    set.each do |interval|
      interval_sure = SystemData.find_by(name: "#{interval.camelize.constantize.table_name}_sure")
      interval_sure ||= SystemData.create name: "#{interval.camelize.constantize.table_name}_sure", val: Minute.order('time asc').first.time.end_of_day + 1

      load_interval interval, interval_sure.val, SystemData.find_by(name: 'minutes_sure').val
      interval_sure.update_attribute(:val, interval.camelize.constantize.last.time)
    end
  end

  def self.load_interval interval_size, start_time, end_time, logger = BeoLogger
    model = interval_size.camelize.constantize
    interval = MOD_INT[model.to_s]
    time, end_time = round_to_interval(start_time, interval), round_to_interval(end_time, interval)
    model.delete_all(["time >= ? AND time <= ?", time, end_time])
    batch = []
    while time <= end_time
      pool = Minute.where('time >= ? AND time < ?', time, time + interval).order('time asc').to_a

      if pool.blank?
        time += 1.minute
        next
      end

      open = pool.first.open
      close = pool.last.close
      low = pool.map(&:low).min
      high = pool.map(&:high).max
      amount = pool.map(&:amount).sum
      tramount = pool.map(&:tramount).sum

      instance = model.new time: time, open: open, close: close, high: high, low: low, amount: amount, tramount: tramount
      batch << instance
      time += interval

      if batch.size > 1000 || time > end_time
        logger.log_batch batch
        save_batch batch
        batch = []
      end
    end
  end

  def self.not_sure_for_derivatives_from time
    set = %w(minute15 hour hour4 day).map{|x| "#{x.camelize.constantize.table_name}_sure"}
    SystemData.where(name: set).each {|x| x.update_attribute(:val, time)}
  end
end
