class BtceFollow
  include Sidekiq::Worker
  sidekiq_options :retry => false, :backtrace => true
  
  def perform
    begin 
      Btce.follow
    rescue Exception => e
      SULO10.error "#{Time.now} #{e.message}"
      SULO10.error e.backtrace.join("\n")
      SULO10.info (['-'*100]*5).join("\n")
    end
  end
end