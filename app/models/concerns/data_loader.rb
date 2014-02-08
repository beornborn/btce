require 'csv'

class DataLoader
  class << self
    def load_transactions
      Transaction.delete_all
      records_amount = CSV.read(file_path).size
      ActiveRecord::Base.logger.level = 1

      count = 0
      batch = []
      CSV.foreach(file_path) do |row| 
        time = Time.at(row[0].to_i)
        price = BigDecimal(row[1])
        amount = BigDecimal(row[2])
        batch << Transaction.new(time: time, price: price, amount: amount)
        
        if batch.size == 1000 || (count + batch.size) == records_amount
          save_batch batch
          count += batch.size
          batch = []
          ap count unless Rails.env.test?
        end
      end
    end

    def load_interval interval_size
      model = interval_size.camelize.constantize
      model.delete_all
      ActiveRecord::Base.logger.level = 1

      first_transaction = Transaction.order('time asc').first
      last_transaction = Transaction.order('time desc').first

      enter_time = first_transaction.time
      prev_interval = nil
      batch = []
      pull = Transaction.by_time(enter_time, enter_time + interval_by_model(model)).order('time asc')
      loop do
        interval = if pull.blank?
          model.new time: enter_time,
                     enter: prev_interval.close,
                     close: prev_interval.close,
                     min: prev_interval.close,
                     max: prev_interval.close,
                     amount: 0
        else
          prices = pull.map(&:price)
          model.new time: enter_time,
                     enter: pull.first.price,
                     close: pull.last.price,
                     min: prices.min,
                     max: prices.max,
                     amount: pull.map(&:amount).sum
        end    
        batch << interval
       
        save_batch batch and break if pull.last == last_transaction

        if batch.size == 1000
          save_batch batch
          batch = []
          ap "do for #{enter_time}: price #{interval.enter}$, amount #{interval.amount} btc"
        end

        prev_interval = interval
        enter_time += interval_by_model model
        pull = Transaction.by_time(enter_time, enter_time + interval_by_model(model)).order('time asc')
      end
    end

    def load_transactions_and_intervals set
      set = %w(minute minute3 minute5 minute15 minute30 hour hour2 hour4 hour6 hour12 day day3 day7 transaction) if set == 'all'
      set.each do |elem|
        load_transactions and next if elem == 'transaction' 
        load_interval elem
      end
    end

    private

    def interval_by_model model
      {
        Minute => 1.minute,
        Minute3 => 3.minute,
        Minute5 => 5.minute,
        Minute15 => 15.minute,
        Minute30 => 30.minute,
        Hour => 1.hour,
        Hour2 => 2.hour,
        Hour4 => 4.hour,
        Hour6 => 6.hour,
        Hour12 => 12.hour,
        Day => 1.day,
        Day3 => 3.day,
        Day7 => 7.day
      }[model]
    end 

    def file_path
      "#{Rails.root}/csv_data/btce.csv"
    end

    def save_batch batch
      Transaction.transaction do
        batch.each {|tr| tr.save!}
      end
    end
  end
end