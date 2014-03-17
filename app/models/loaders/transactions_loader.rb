require 'csv'

class TransactionsLoader < DataLoader
  def self.load_tr_for_sure logger = BeoLogger
    transactions_sure = SystemData.find_by(name: 'transactions_sure')
    transactions_sure ||= SystemData.create name: 'transactions_sure', val: Time.at(0)

    last_timestamp = CSV.read('csv_data/btce_transaction_last.csv')[0][0].to_i
    Transaction.delete_all(["time > ? AND time <= ?", transactions_sure.val, Time.at(last_timestamp - 1)])

    batch = []
    CSV.foreach("#{Rails.root}/csv_data/btce_transactions.csv") do |row|
      next if row[0].to_i <= transactions_sure.val.to_i

      batch << tr_by_row(row)
      if batch.size >= 10000
        logger.log_batch batch
        save_batch batch
        batch = []
      end
    end

    logger.log_batch batch if batch.present?
    save_batch batch
    transactions_sure.update_attribute(:val, Time.at(last_timestamp))
  end

  def self.not_sure_from time
    SystemData.find_by(name: 'transactions_sure').update_attribute(:val, time)
  end

  def self.tr_by_row row
    time = Time.at(row[0].to_i)
    price = BigDecimal(row[1])
    amount = BigDecimal(row[2])
    Transaction.new(time: time, price: price, amount: amount)
  end
end
