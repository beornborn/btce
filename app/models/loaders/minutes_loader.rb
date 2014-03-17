class MinutesLoader < DataLoader
  def self.load_minutes_for_sure
    minutes_sure = SystemData.find_by(name: 'minutes_sure')
    minutes_sure ||= SystemData.create name: 'minutes_sure', val: Time.at(Transaction.order('time asc').first.time)

    load_minutes minutes_sure.val, SystemData.find_by(name: 'transactions_sure').val
    minutes_sure.update_attribute(:val, Minute.last.time)
  end

  def self.load_minutes start_time, end_time, logger = BeoLogger
    time, end_time = round_to_interval(start_time, 1.minute), round_to_interval(end_time, 1.minute)
    Minute.delete_all(["time >= ? AND time <= ?", time, end_time])
    prev_instance = nil

    batch = []
    while time <= end_time
      pool = Transaction.where('time >= ? AND time < ?', time, time + 1.minute).order('time asc').to_a

      if pool.blank? && prev_instance.nil?
        time += 1.minute
        next
      end

      instance = if pool.blank?
        Minute.new time: time,
                   open: prev_instance.close,
                   close: prev_instance.close,
                   low: prev_instance.close,
                   high: prev_instance.close,
                   amount: 0,
                   tramount: 0
      else
        prices = pool.map(&:price)
        Minute.new time: time,
                   open: pool.first.price,
                   close: pool.last.price,
                   low: prices.min,
                   high: prices.max,
                   amount: pool.map(&:amount).sum,
                   tramount: pool.size
      end

      batch << instance

      prev_instance = instance
      time += 1.minute

      if batch.size > 1000 || time > end_time
        logger.log_batch batch
        save_batch batch
        batch = []
      end
    end
  end

  def self.not_sure_from time
    SystemData.find_by(name: 'minutes_sure').update_attribute(:val, time)
  end
end
