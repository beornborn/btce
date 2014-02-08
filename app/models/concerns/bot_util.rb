module BotUtil
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def save_batch batch
      ActiveRecord::Base.transaction do
        batch.each {|r| r.save!}
      end
    end

    def tr_by_row row
      time = Time.at(row[0].to_i)
      price = BigDecimal(row[1])
      amount = BigDecimal(row[2])
      Transaction.new(time: time, price: price, amount: amount)
    end

    def round_to_interval time, interval
      Time.at(time.to_i - time.to_i % interval)
    end
  end
end
