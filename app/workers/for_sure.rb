class ForSure
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options :backtrace => true
  recurrence { hourly(4) }

  def perform
    DataLoader.load_all_for_sure
  end
end
