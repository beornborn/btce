task :sidekiq =>:environment do
  BtceFollow.perform_async
  UpdateMinutes.perform_async
  ForSure.perform_async
  UpdateOther.perform_async
end
