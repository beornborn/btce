class IchimokuForSure
  include Sidekiq::Worker
  sidekiq_options :retry => false, :backtrace => true

  def perform(indicator_id)
    begin
      ichimoku = Indicator.find(indicator_id)
      IchimokuLoader.load_ichimoku_for_sure ichimoku
    rescue Exception => e
      SULO6.error "#{Time.now} #{e.message}"
      SULO6.error e.backtrace.join("\n")
      SULO6.info (['-'*100]*5).join("\n")
    end
  end
end
