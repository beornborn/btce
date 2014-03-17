class DataLoader
  include BotUtil

  def self.load_all_for_sure
    # `"#{Rails.root}/gettr.sh"`
    # TransactionsLoader.load_tr_for_sure
    # MinutesLoader.load_minutes_for_sure
    # IntervalsLoader.load_interval_for_sure
    IchimokuLoader.load_all_ichimokus_for_sure
  end
end
