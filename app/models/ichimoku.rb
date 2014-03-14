# http://enc.fxeuroclub.ru/117/
class Ichimoku < ActiveRecord::Base
  belongs_to :indicator

  def self.the_best
    Indicator.find_by(name: 'ichimoku_original_19440.0')
  end
end
