class T
  def self.t
    begin 
      a
    rescue Exception => e
      SULO9.error e.backtrace.join("\n")
      SULO9.info (['-'*100]*5).join("\n")
    end
  end
end