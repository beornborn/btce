class ActiveRecord::Base     
  def self.save_batch batch
    self.transaction do
      batch.each {|r| r.save!}
    end
  end
end