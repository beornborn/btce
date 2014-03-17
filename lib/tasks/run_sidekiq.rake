task :sidekiq =>:environment do
  # BtceFollow.perform_async
  # UpdateIntervals.perform_async
  ForSure.perform_async
end
