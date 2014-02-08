class UpdateMinutes 
  include Sidekiq::Worker
  sidekiq_options :retry => false, :backtrace => true
  
  def perform
    begin 
      loop do 
        last_min_time = Minute.order('time asc').last.time
        last_tr_time = Time.at Transaction.order('time asc').last.time
        last_tr_time -= last_tr_time.sec

        MinutesLoader.load_minutes last_min_time, last_tr_time, SULO2
        
        sleep 1.minute
      end
    rescue Exception => e
      SULO10.error "#{Time.now} #{e.message}"
      SULO10.error e.backtrace.join("\n")
      SULO10.info (['-'*100]*5).join("\n")
    end
  end
end