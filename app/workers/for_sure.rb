class ForSure
  include Sidekiq::Worker
  sidekiq_options :backtrace => true

  def perform
    DataLoader.load_all_for_sure
  end
end
