require 'csv'

class TransactionsLoader < DataLoader
  def self.load_tr_for_sure logger = BeoLogger
    transactions_sure = SystemData.find_by(name: 'transactions_sure')
    last_timestamp = CSV.read('csv_data/btce_transaction_last.csv')[0][0].to_i
    Transaction.delete_all(["time > ? AND time <= ?", transactions_sure.val, Time.at(last_timestamp - 1)])

    batch = []
    CSV.foreach("#{Rails.root}/csv_data/btce_transactions.csv") do |row|
      next if row[0].to_i <= transactions_sure.val.to_i

      batch << tr_by_row(row)
      if batch.size >= 10000
        log logger, batch
        save_batch batch
        batch = []
      end
    end

    log logger, batch if batch.present?
    save_batch batch
    transactions_sure.update_attribute(:val, Time.at(last_timestamp))
  end

  def self.log logger, batch
    logger.info "------------------------------- new transactions batch #{Time.now} ----------------------------------------"
    logger.info "batch size: #{batch.size}"
    logger.info "first instance--- time: #{Time.at(batch.first.time)} open: #{batch.first.price} amount: #{batch.first.amount}"
    logger.info "last instance---- time: #{Time.at(batch.last.time)} open: #{batch.last.price} amount: #{batch.last.amount}"
  end

  def self.not_sure_from time
    SystemData.find_by(name: 'transactions_sure').update_attribute(:val, time)
  end
end
