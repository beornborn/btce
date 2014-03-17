class BtceFollow
  include Sidekiq::Worker
  sidekiq_options :backtrace => true

  def perform
    Btce.follow
  end
end
