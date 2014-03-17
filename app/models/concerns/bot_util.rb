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

    def round_to_interval time, interval
      Time.at(time.to_i - time.to_i % interval)
    end
  end
end
