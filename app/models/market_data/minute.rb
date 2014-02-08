require 'csv'

class Minute < ActiveRecord::Base
  FIRST = Time.at(1291154400)
  LAST  = Time.at(1387663140)
  
  def self.load_from_csv
    file_path = "#{Rails.root}/csv_data/eurusd_min.csv"
    Minute.delete_all
    records_amount = CSV.read(file_path).size
    ActiveRecord::Base.logger.level = 1

    count = 0
    batch = []
    CSV.foreach(file_path) do |row| 
      time = Time.parse(row[0])
      open = BigDecimal(row[1])
      high = BigDecimal(row[2])
      low = BigDecimal(row[3])
      close = BigDecimal(row[4])
      amount = BigDecimal(row[5])
      batch << Minute.new(time: time, open: open, high: high, low: low, close: close, amount: amount)
      
      if batch.size == 1000 || (count + batch.size) == records_amount
        save_batch batch
        count += batch.size
        batch = []
        ap count unless Rails.env.test?
      end
    end
  end

  def self.load_piece
    file_path = "#{Rails.root}/csv_data/piece.csv"
    records_amount = CSV.read(file_path).size
    ActiveRecord::Base.logger.level = 1

    count = 0
    batch = []
    CSV.foreach(file_path) do |row| 
      time = Time.parse(row[0])
      open = BigDecimal(row[1])
      high = BigDecimal(row[2])
      low = BigDecimal(row[3])
      close = BigDecimal(row[4])
      amount = BigDecimal(row[5])
      batch << Minute.new(time: time, open: open, high: high, low: low, close: close, amount: amount)
      
      if batch.size == 1000 || (count + batch.size) == records_amount
        save_batch batch
        count += batch.size
        batch = []
        ap count unless Rails.env.test?
      end
    end
  end

  def self.save_batch batch
    Minute.transaction do
      batch.each {|tr| Minute.where(time: tr.time).delete_all; tr.save!}
    end
  end
end
